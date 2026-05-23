---
layout: archive
title: "Dada Science"
permalink: /projects/dada_science
author_profile: true
redirect_from:
---

I became a full-time caregiver and started spending my days with a toddler.

After enough time you start to read them. You notice patterns. I decided to do something useful with that rather than just observe it.

The library book recommender came first. The problem was concrete: we were burning library holds on books Heiki would inspect for four seconds and set face-down. The scraper pulls the Sno-Isle catalog nightly via the BiblioCommons API — roughly 165,000 titles across genres, audiences, and formats. A Flask web UI runs on a Raspberry Pi in the house; three users (Heiki, Simon, Madeleine) share the catalog and maintain independent taste profiles. The engine is TF-IDF plus cosine similarity: it builds a preference fingerprint from books you've rated or engaged with, weighted across four signals — star ratings, rereads, reads, and false starts — and ranks unread books against that fingerprint. Holds go through the BiblioCommons API directly from the interface.

The week planner came next. It's a CLI tool for building and managing a weekly schedule: activities in append-only per-week JSON files, Rich terminal display, interactive editing via questionary. The Google Calendar integration supports push (plan to GCal, idempotent re-push) and pull (external events into the local file). Activities carry an optional location field that renders as a Maps link in the terminal and populates GCal's native location on push. Multi-account pull normalizes timezones across calendars.

Both are in daily use. The code is on <a href="https://github.com/simonhansedasi/dada_science" target="_blank">GitHub</a>.
