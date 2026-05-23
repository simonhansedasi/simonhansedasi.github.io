---
layout: archive
title: "GeoGastronomy"
permalink: /projects/geogastronomy
author_profile: true
redirect_from:
  - /projects/grapeexpectations
---

I found myself at a wine tasting at Turnbull Winery in Napa. The server was describing how the position of a vine within the vineyard — its row, its elevation, its exposure — produces measurable variance in the grape and ultimately in the wine. I was fascinated. The question underneath it was familiar: how much does location explain outcome, and can you measure it precisely?

So I went home and started drawing polygons on Google Earth.

**GrapeExpectations** is a precision viticulture pipeline built around that question. The study area is a Washington State wine production region — 3,598 equal-area hexagonal cells at 1,000 m² each, covering nine years of Sentinel-2 satellite imagery, PRISM climate records, USGS topography, and gSSURGO soil data. The pipeline assembles those layers, engineers features from the DEM (slope, curvature, aspect, local relief), pulls spectral indices via Google Earth Engine, and stacks them into a multi-output ensemble: Random Forest, ExtraTrees, Gradient Boosting, XGBoost, and KNN feeding into an ElasticNet meta-learner. The target is weekly NDVI across the growing season — a proxy for vine canopy density and vigor. The stacked model hits R² = 0.967 on the held-out tune set. A companion analysis produces a frost risk raster by combining topographic position, elevation deviation, and NDVI history. I also reached out to Washington State University about the approach, and we explored deployment of Distributed Temperature Sensing fiber optic cables for direct canopy temperature measurement — the same photonic sensing technology I worked with at the UW Photonic Sensing Lab.

The vineyard work raised a version of the question I hadn't expected: does this generalize? A vine in a particular microclimate is one data point in a larger pattern. What about coffee?

**JavaScript** (named for the Kona district, not the language) maps current and projected coffee suitability across Hawaiʻi's Big Island — Kona and Kaʻu — at 500m resolution. The pipeline follows the same logic: hexagonal grid, terrain features from the DEM, ERA5-Land climate variables, Sentinel-2 NDVI composites, and SSURGO soil data, assembled into a labeled feature matrix from 674 coffee-farm polygons. A Random Forest classifier distinguishes coffee-farm cells from background; PCA extracts the environmental fingerprint of each district; k-means identifies microclimate zones within each region. The two districts turn out to be quite different — different thermal optima, different feature importance profiles, different climate variance explained. Forward projections using NEX-GDDP-CMIP6 (SSP2-4.5 and SSP5-8.5) extend the analysis to 2035 and 2045. Under projected warming, Kona's thermal window contracts upslope. Kaʻu's expands.

That result pointed somewhere bigger. If altitude and climate shape the chemistry of where coffee grows, do they shape the chemistry of the coffee itself? And if they do for coffee, do they do it for tea, for apples, for dairy?

**TerraMetabolica** is the attempt to answer that systematically. The framework is built around Region Sample Units — 65 RSUs spanning boreal Finland to the Himalayan plateau, each defined by climate, geology, altitude, and 4–6 native staple foods. Metabolite values are assembled from USDA FoodData Central and primary literature: organic acids, polyphenols, fatty acids, terpenes, umami compounds. The patterns that emerge are not subtle. Elevation shows consistent directional associations with protective metabolite concentrations across unrelated biological systems on multiple continents — chlorogenic acids in Arabica coffee, catechins in green tea, malic acid in apples, conjugated linoleic acid in grass-fed dairy. These are different crops, different synthesis pathways, different continents, pointing the same direction. Coconut lauric acid, genetically constrained, shows no altitude relationship across five RSUs — an intentional null that confirms the framework is discriminating rather than just inflating everything. The North American Prairie RSU has zero measured bioactive compounds across its staple foods. That absence is itself a finding.

The pipeline also runs in the other direction. Rather than asking what a location does to a crop's chemistry, you can ask where a crop belongs — and whether you can answer that question without any labeled data at all.

**KushCountry** applies the same hexagonal grid architecture to outdoor cannabis in California's Emerald Triangle with one structural constraint: the California Department of Cannabis Control withholds all spatial data for licensed cultivators. No training polygons exist. Terrain, climate, soil, and satellite canopy structure (Sentinel-2 NDVI) across 8,900 hexagonal cells are stacked, scaled, and handed to k-means without labels; the question is whether the resulting clusters self-organize around documented cultivation conditions. The answer is cluster 0: mean elevation 527m, growing degree days 1,395, vapor pressure deficit 1,568 Pa — mid-elevation interior, warm-dry Mediterranean conditions, the recognized Emerald Triangle cultivation profile. It covers 22.2% of the study area. Enforcement records from the Regional Water Quality Control Board confirm the archetype independently: cluster 0 is only 2.9% of Humboldt County terrain but 9.9% of documented violation parcels, a lift of 3.41. The archetype recovers at four of four agronomic criteria across K=4 through K=7; bootstrap cluster stability averages ARI=0.974 across 50 subsamples.

The framework — Unsupervised Terrain Fingerprinting — generalizes to any specialty crop where cultivation locations are suppressed, restricted, or absent.

The whole thing lives under one umbrella now: GeoGastronomy. The code is on <a href="https://github.com/simonhansedasi/GeoGastronomy" target="_blank">GitHub</a>.
