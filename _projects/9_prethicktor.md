---
layout: archive
title: "Glacier Thickness Predictor"
permalink: /projects/prethicktor
author_profile: true
redirect_from:
---
An accurate estimation of glacier volume is essential for effective water resource
management and sea-level rise projections, however, traditional methods for assessing glacier
thickness are costly and labor-intensive. This study presents a novel approach to estimating
glacier thickness utilizing neural networks trained on thickness data from the Glacier Thickness
Database (GlaThiDa) and glacier attributes, such as area or slope, from the Randolph Glacier
Inventory (RGI). A regression analysis is conducted on a subset of GlaThiDa data, which is then
used to infer thicknesses for glaciers in the RGI dataset. Challenges in matching GlaThiDa
thickness data to RGI attributes are addressed, employing distance and area thresholds to en-
sure the matched GlaThiDa thickness is representative of RGI attributes. Furthermore, this
study provides a comprehensive comparison with existing global estimates. Notably, this study
has lower estimates of volume for shelf and marine-terminating glaciers due to a sparsity of
available training data. These findings suggest the neural network effectively models a world
without ice shelves and their buttressing effect on ice flow. This departure from previous meth-
ods and estimates emphasizes the importance of improved observations of glacier thickness
data, particularly in marine environments
<p align="center">
  <img src="/images/discrepancy_boxplot.png" width = "500" />
</p>
