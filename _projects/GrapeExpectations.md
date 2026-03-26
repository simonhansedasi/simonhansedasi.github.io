---
layout: archive
title: "GrapeExpectations"
permalink: /projects/grapeexpectations
author_profile: true
redirect_from:
---

I found myself at a wine tasting at Turnbull Winery in Napa. The server was describing how the position of a vine within the vineyard — its row, its elevation, its exposure — produces measurable variance in the grape and ultimately in the wine. I was fascinated. The question underneath it was familiar: how much does location explain outcome, and can you measure it precisely?

So I went home and started drawing polygons on Google Earth.

The project began by computing field geometry from measured acreage and row spacing — row counts, vine counts, wire lengths for trellis installation. Practically useful numbers, but that was the warm-up. The more interesting work was in the sensing data: using ridge regression to model how canopy-level variables relate to grape quality metrics, asking whether the variance the sommelier was describing could be captured quantitatively.

I reached out to Washington State University to see if the approach was worth pursuing at scale. They thought it was. We are now exploring deployment of Distributed Temperature Sensing (DTS) fiber optic cables to measure canopy temperature across vineyard rows — the same photonic sensing technology I worked with at the UW Photonic Sensing Lab, now applied to viticulture.

The code is on <a href="https://github.com/simonhansedasi/GrapeExpectations" target="_blank">GitHub</a>.
