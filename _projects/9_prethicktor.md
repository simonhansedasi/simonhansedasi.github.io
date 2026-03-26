---
layout: archive
title: "Tidewater and lake-terminating glaciers are systematically thicker"
permalink: /projects/prethicktor
author_profile: true
redirect_from:
---
<a href="https://doi.org/10.1017/jog.2026.10123" target="_blank">Published in <i>Journal of Glaciology</i>, 2026</a><br><br>

Tidewater and lake-terminating glaciers are systematically thicker than glaciers ending on land — and that difference accounts for roughly 20% of non-ice-sheet global glacier volume.

We arrived at this by training a shallow neural network on glacier-averaged thickness measurements from GlaThiDa and surface attributes from the Randolph Glacier Inventory (216,501 glaciers globally), then comparing models trained with and without water-terminating glaciers in the training set. The gap between those models is the imprint of ice-ocean interaction on global ice volume. It is consistent with a simple mechanical explanation: water pressure at the ice front permits thicker termini than are stable in air, setting a different boundary condition for equilibrium glacier geometry.

The pipeline handles the messy reality of co-registering two independently maintained global datasets across different measurement epochs, using distance and area thresholds to filter unreliable matches. Leave-one-out cross-validation across 273 co-registered glaciers produces per-glacier uncertainty estimates that propagate through to a global volume uncertainty budget.
<p align="center">
  <img src="/images/discrepancy_boxplot.png" width = "700" />
</p>
