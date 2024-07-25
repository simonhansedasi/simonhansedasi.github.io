require 'json'

# Define the path to the directory containing the markdown haiku files
haikus_dir = '_haikus'

# Initialize an empty array to hold the haikus
haikus = []

# Iterate over each markdown file in the directory
Dir.glob("#{haikus_dir}/**/*.md") do |file|
  puts "Processing file: #{file}"  # Debug: Print the file being processed

  # Read the content of the file
  content = File.read(file)

  # Split the content by "---" to separate the front matter from haikus
  parts = content.split('---').map(&:strip)

  # Ensure there are at least two parts (front matter and haikus)
  next if parts.length < 3

  # Extract the date from the front matter (second part)
  title_part = parts[1].match(/title:\s*"([^"]+)"/)
  date = title_part[1].strip if title_part

  # Extract the full date from the haiku lines
  haikus_content = parts[2..-1] # Skip the front matter part
  haikus_content.each do |haiku_part|
    haiku_part.strip!

    # Skip if the part is empty or does not have at least 3 lines
    next if haiku_part.empty? || haiku_part.lines.count < 3

    # Extract haiku details
    haiku_lines = haiku_part.split("\n").reject(&:empty?)
    number = haiku_lines[0].split(' ')[1].strip
    date_from_haiku = haiku_lines[0].split(' ')[0].strip # Extract date from the haiku line

    # Combine the front matter date and the date from the haiku if needed
    date = date_from_haiku unless date_from_haiku.empty?

    if haiku_lines.length >= 3
      # Create a hash for the haiku
      haiku_hash = {
        "date" => date,
        "number" => number,
        "content" => haiku_lines[1..-1].join("\n")  # Exclude the date line
      }

      # Add the hash to the haikus array
      haikus << haiku_hash
    end
  end
end

# Write the array of haikus to a JSON file
File.open('_data/haikus.json', 'w') do |f|
  f.write(JSON.pretty_generate(haikus))
end

puts "Haikus have been written to _data/haikus.json"
