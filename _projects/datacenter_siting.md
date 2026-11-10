---
layout: archive
title: "Siting the Grid"
permalink: /projects/datacenter-siting
author_profile: true
---

<a href="https://datacenters.simonhansedasi.com" target="_blank">Live briefing at datacenters.simonhansedasi.com</a><br><br>

<em>This is the Washington-only version. The method has since been rebuilt for 48 states as <a href="/projects/merascope">Merascope</a>.</em><br><br>

Washington's data center industry picked Grant County for one reason: cheap hydropower and proximity to high-voltage transmission lines. That single-variable optimization is now colliding with water scarcity, grid saturation, and community opposition. The industry's answer has been to add more of the same — and some of those bets are getting canceled.

This project asks what a more defensible siting decision looks like, quantitatively.

**The model** covers Washington State as a 0.15-degree fishnet grid (974 cells, roughly 14 km each) scored on five normalized indicators: transmission proximity, water availability, community burden, seismic hazard, and flood risk. All inputs are open data: OpenStreetMap for transmission infrastructure, Open-Meteo ERA5 for 30-year precipitation normals, U.S. Census ACS for the demographic burden index, USGS ASCE 7-22 for peak ground acceleration, and FEMA's National Flood Hazard Layer. Distances run in UTM Zone 10N; scores normalize to 0–1 before weighting.

The central finding is not subtle. The Quincy corridor — home to Microsoft, CyrusOne, Vantage, Sabey, H5, and Dell — scores near-perfect on transmission proximity (0.988) and seismic safety (0.885), and then 0.189 on water availability. The Columbia Basin receives roughly 640 mm of precipitation per year; the grid's water allocation is effectively fully subscribed. Grant County PUD has said so publicly. The composite score for Quincy under default weights is 0.599.

The Digital Realty proposed site, 50 km west in the Cascade foothills, scores 0.783 under the same weights. Same grid access class; 1,441 mm of annual precipitation. The gap closes substantially when seismic weight increases: Puget Sound PGAM values run 0.5–1.0g, against 0.15–0.2g in the Columbia Basin, reflecting Cascadia subduction zone amplification and the Seattle Fault. The Kittitas/Ellensburg corridor comes out as the practical sweet spot — precipitation in the mid-range, seismic hazard lower than the coast, grid access strong.

The Tukwila corridor (HorizonIQ, ColoCrossing) produces the most interesting secondary finding. Grid access and water scores are among the highest in the state; the community burden score is 0.109, the lowest of any active cluster in the analysis. The SR-99 industrial corridor already carries disproportionate environmental load. That combination — infrastructure-optimal, community-burdened — is exactly what EJ policy frameworks are designed to flag, and exactly what a single-variable site selection process misses.

Canceled projects validate the model without any parameter tuning. Data centers blocked or withdrawn in WA over the past two years all score high on grid access and low on water availability; the pre-siting screen would have flagged every case.

The most pointed validation is prospective. A new cluster is forming in the Tri-Cities / southeast Columbia Basin — the driest corner of the state, receiving 150–220 mm of annual precipitation. Every proposed site there scores water = 0.000, the floor of this analysis. Amazon's $4.8B Wallula Gap campus (554 acres, Burbank, approved February 2026), Atlas Agro's $500M Richland DC1 (275 acres at Horn Rapids Road, approved December 2025), and Trammell Crow's Lewis &amp; Clark Ranch campus (up to 1,000 acres, West Richland) all fall in the same band; composite scores range 0.506–0.583, below the already water-constrained Quincy cluster. The industry is moving deeper into arid eastern Washington at exactly the moment the state is legislating mandatory water-use reporting.

The analysis is fully reproducible from three Jupyter notebooks and publicly available data. The live briefing at <a href="https://datacenters.simonhansedasi.com" target="_blank">datacenters.simonhansedasi.com</a> includes an interactive Leaflet map with five weight sliders, so the tradeoff space is explorable rather than fixed.
