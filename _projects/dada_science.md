---
layout: archive
title: "Dada Science"
permalink: /projects/dada_science
author_profile: true
redirect_from:
---

I became a full-time caregiver and started spending my days with a toddler.

After enough time you start to read them. You notice patterns — which conditions produce a meltdown, which snack at which time of day is the real variable, how sleep debt compounds. I decided to put it to paper. Or rather, to put it to data.

Dada Science is a collection of analytical studies on toddler behavior conducted with the same rigor I would bring to any other system under observation. The subject is absurd. The methods are not. Two-way ANOVA to isolate whether sugar content or time of day drives tantrum duration. STL decomposition on a 141-day nap time series to separate the effects of declining daylight from DST. An ARIMAX model treating berry season as a natural experiment in nap compliance. All data is synthetic — generated with seeded NumPy for reproducibility — but the questions are real.

The project has since grown beyond the studies. There is now a Flask app running on a Raspberry Pi in my house, accessible over Tailscale, that logs sleep, food, activities, meltdowns, mood, and potty events in real time. I launched it today. No findings yet.

There is also a library book recommender that scrapes the Sno-Isle catalog, learns from ratings, and surfaces books via TF-IDF cosine similarity — because once you have the infrastructure, you keep building.

The code is on <a href="https://github.com/simonhansedasi/dada_science" target="_blank">GitHub</a>.
