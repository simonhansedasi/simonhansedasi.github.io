#!/usr/bin/env ruby
# frozen_string_literal: true
#
# build.rb — static site generator (replaces Jekyll)
#
# Usage:
#   bundle exec ruby build.rb          # build to _site/
#   ruby -run -e httpd _site -p 4000   # serve locally

require "yaml"
require "erb"
require "kramdown"
require "kramdown-parser-gfm"
require "fileutils"
require "time"

# ---------------------------------------------------------------------------
# Site configuration
# ---------------------------------------------------------------------------

SITE = {
  "title"        => "Edasi Koduleht",
  "analytics_id" => "G-7B3V0WDVWN",
  "author"       => {
    "name"     => "Simon Hans Edasi",
    "bio"      => "Data scientist and geophysicist. UW graduate. Seattle, WA.",
    "email"    => "simonhansedasi@gmail.com",
    "github"   => "simonhansedasi",
    "location" => "Seattle, WA",
    "avatar"   => "/images/profile.jpg"
  },
  "nav" => [
    { "title" => "Projects",  "url" => "/projects/" },
    { "title" => "Art",       "url" => "/art/" },
    { "title" => "Portfolio", "url" => "http://simonhansedasi.github.io/portfolio/" },
    { "title" => "CV",        "url" => "/cv/" }
  ]
}

# Pages to build from _pages/ (allowlist by basename, without extension)
INCLUDE_PAGES = %w[about cv art charactermancer haikus projects 404].freeze

OUTPUT_DIR   = "_site"
TEMPLATE_DIR = "templates"
SRC_ROOT     = File.dirname(File.expand_path(__FILE__))
LAYOUT       = File.join(SRC_ROOT, TEMPLATE_DIR, "layout.html.erb")

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def parse_front_matter(raw)
  if raw =~ /\A---\s*\n(.*?)\n---\s*\n?(.*)/m
    fm = YAML.safe_load(Regexp.last_match(1)) || {}
    [fm, Regexp.last_match(2)]
  else
    [{}, raw]
  end
end

# Remove Liquid syntax from content so Kramdown doesn't choke on it
def strip_liquid(text)
  text
    .gsub(/\{%-?\s*include\s+\S.*?-?%\}/m, "")
    .gsub(/\{%-?\s*for\s+.*?-?%\}.*?\{%-?\s*endfor\s*-?%\}/m, "")
    # {{ '/path' | relative_url }} or {{ "/path" | relative_url }} → /path
    .gsub(/\{\{\s*'([^']+)'\s*\|\s*relative_url\s*\}\}/) { Regexp.last_match(1) }
    .gsub(/\{\{\s*"([^"]+)"\s*\|\s*relative_url\s*\}\}/) { Regexp.last_match(1) }
    # {{ '/path' }} or {{ "/path" }} → /path (no filter)
    .gsub(/\{\{\s*'([^']+)'\s*\}\}/) { Regexp.last_match(1) }
    .gsub(/\{\{\s*"([^"]+)"\s*\}\}/) { Regexp.last_match(1) }
    # remove any remaining {{ ... }} and {% ... %}
    .gsub(/\{\{[^}]+\}\}/, "")
    .gsub(/\{%[^%]+%\}/, "")
end

def md_to_html(md)
  Kramdown::Document.new(md, input: "GFM", syntax_highlighter: "rouge").to_html
end

# When a page body is a full HTML document, extract just the <body> content
def extract_body_content(html)
  return html unless html.strip =~ /\A<!DOCTYPE|<html/i

  html.match(/<body[^>]*>(.*?)<\/body>/mi)&.captures&.first&.strip || html
end

def render_layout(vars = {})
  tmpl = ERB.new(File.read(LAYOUT), trim_mode: "-")
  b = binding
  b.local_variable_set(:site, SITE)
  vars.each { |k, v| b.local_variable_set(k.to_sym, v) }
  tmpl.result(b)
end

def build_page(permalink:, title:, content:, extra_head: nil)
  render_layout(
    page_title: title,
    content:    content,
    current_url: permalink,
    extra_head:  extra_head
  )
end

def out_path(permalink)
  clean = permalink.to_s.sub(%r{\A/}, "")
  if clean.end_with?(".html")
    File.join(OUTPUT_DIR, clean)
  elsif clean.empty?
    File.join(OUTPUT_DIR, "index.html")
  else
    File.join(OUTPUT_DIR, clean.chomp("/"), "index.html")
  end
end

def write_page(path, html)
  FileUtils.mkdir_p(File.dirname(path))
  File.write(path, html)
  puts "  #{path.sub("#{SRC_ROOT}/", "")}"
end

# ---------------------------------------------------------------------------
# Build
# ---------------------------------------------------------------------------

puts "==> Cleaning #{OUTPUT_DIR}/"
FileUtils.rm_rf(OUTPUT_DIR)
FileUtils.mkdir_p(OUTPUT_DIR)

puts "==> Copying static assets"
%w[assets images files].each do |dir|
  src = File.join(SRC_ROOT, dir)
  dst = File.join(OUTPUT_DIR, dir)
  FileUtils.cp_r(src, dst) if Dir.exist?(src)
end

# ---------------------------------------------------------------------------
# Collect collections
# ---------------------------------------------------------------------------

puts "==> Collecting projects"
projects = Dir.glob(File.join(SRC_ROOT, "_projects/*.md")).sort.reverse.map do |f|
  raw = File.read(f)
  fm, body = parse_front_matter(raw)
  next unless fm["permalink"]

  { "title" => fm["title"], "url" => fm["permalink"], "body" => strip_liquid(body) }
end.compact

puts "==> Collecting haikus"
haikus = Dir.glob(File.join(SRC_ROOT, "_haikus/*.md")).sort.reverse.map do |f|
  raw = File.read(f)
  fm, body = parse_front_matter(raw)
  next unless fm["permalink"]

  { "title" => fm["title"], "url" => fm["permalink"], "body" => body }
end.compact

# ---------------------------------------------------------------------------
# Render collection item pages
# ---------------------------------------------------------------------------

puts "==> Rendering project pages"
projects.each do |p|
  html = build_page(
    permalink: p["url"],
    title:     p["title"],
    content:   md_to_html(p["body"])
  )
  write_page(out_path(p["url"]), html)
end

puts "==> Rendering haiku pages"
haikus.each do |h|
  html = build_page(
    permalink: h["url"],
    title:     h["title"],
    content:   md_to_html(h["body"])
  )
  write_page(out_path(h["url"]), html)
end

# ---------------------------------------------------------------------------
# Render main pages
# ---------------------------------------------------------------------------

puts "==> Rendering main pages"

def projects_list_html(projects)
  items = projects.map do |p|
    "<li><a href=\"#{p['url']}\">#{p['title']}</a></li>"
  end.join("\n    ")
  "<ul class=\"archive-list\">\n    #{items}\n  </ul>"
end

def haikus_list_html(haikus)
  items = haikus.map do |h|
    "<li><a href=\"#{h['url']}\">#{h['title']}</a></li>"
  end.join("\n    ")
  "<ul class=\"archive-list\">\n    #{items}\n  </ul>"
end

Dir.glob(File.join(SRC_ROOT, "_pages/**/*")).sort.each do |file|
  next unless File.file?(file)

  basename = File.basename(file, ".*")
  next unless INCLUDE_PAGES.include?(basename)

  raw = File.read(file)
  fm, body = parse_front_matter(raw)

  permalink  = fm["permalink"] || "/"
  title      = fm["title"] || basename.capitalize
  extra_head = nil

  # Collection index pages — replace Liquid loops with generated HTML
  content_html = case basename
  when "projects"
    projects_list_html(projects)
  when "haikus"
    haikus_list_html(haikus)
  else
    # Strip Liquid from all other pages
    body = strip_liquid(body)

    # Art page: extract body content from inner HTML doc, inject script via head
    if basename == "art"
      body = extract_body_content(body)
      extra_head = '<script src="/assets/js/fetchContent.js" defer></script>'
    end

    file.end_with?(".md") ? md_to_html(body) : body
  end

  html = build_page(
    permalink:  permalink,
    title:      title,
    content:    content_html,
    extra_head: extra_head
  )
  write_page(out_path(permalink), html)
end

puts "\n==> Done! Site built to #{OUTPUT_DIR}/"
puts "    Serve: ruby -run -e httpd #{OUTPUT_DIR} -p 4000"
