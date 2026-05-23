---
layout: archive
title: "Seismic Ringing"
permalink: /projects/ringing
author_profile: true
redirect_from:
---
In November 2022, a fiber optic cable running under Red Square on the University of Washington Seattle campus picked up something nobody had asked for.

The UW Photonic Sensing Lab operates a distributed acoustic sensing array: a fiber optic cable connecting UW Seattle to UW Bothell, running the length of the city and sampling ground motion across thousands of channels at roughly 6 meter spacing. We were searching for signals from trains moving through underground tunnels to audit their schedule. While scanning repeating 10-minute windows of data, we found instead a series of high-amplitude, low-frequency events centered under Red Square between the evening of November 10 and the afternoon of November 14, 2022.
<p align="center">
  <img src="/images/ring.png" width = "700"/>
</p>

It is currently unknown what is causing these signals as they span several channels of approximately 6 meter spacing per channel and do not always have similar features. An early hypothesis suggested these could be percussive signals from a nearby marching band or similar performance, however the events occur throughout the day and are non-dispersive. A percussive signal should be detected farther along the cable and be dispersive, however these detected signals are confined to only a few channels.

These signals are also accompanied by long "ring-down" time after detecting extremely large amplitudes as if the cable were kicked or picked up. There are also periods of extended shaking of several minutes as if a jackhammer is being operated right next to the cable. A likely candidate for these signals could easily be construction or maintenance in the parking garage below Red Square.

Two steps would narrow it down: a tap test in or under Red Square to precisely locate the cable within the structure, and a review of facilities maintenance records for the parking garage during those dates.

When large amplitudes were detected, the data was passed through two bandpass filters (0.01–0.1 Hz and 0.1–1 Hz) and plotted as a space-time heatmap. Selecting a single channel then revealed the ring-down in the time series — signals persisting for over a minute after the initial event.

