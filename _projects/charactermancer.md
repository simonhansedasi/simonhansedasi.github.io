---
layout: archive
title: "Character-mancer"
permalink: /projects/charactermancer
author_profile: true
redirect_from:
---
I was bored in grad school. I started a D&D group with a bunch of people who had never played before, which meant I was constantly building characters from scratch. At some point I decided to automate it — and once you have an automated character funnel, you have a simulation, and once you have a simulation you have data.

So I ran 10,000 characters through the 2014 Player’s Handbook rules and wrote up what came out.

The simulator rolls attributes using the 4d6-drop-lowest method with two constraints: at least one score must be 16 or higher, and the average must be at least 12. Species, class, background, and alignment are then selected by weighted matching against the rolled array. Chi-squared residuals and correlation matrices reveal where the mechanics produce non-obvious outcomes.

A few things stood out. Strength and Dexterity are moderately negatively correlated — not because the game intends this, but because sequential generation and species bonus mechanics create it as an artifact. Intelligence is systematically underutilized as a primary class attribute. Gnomes and Tieflings are structurally disadvantaged: their species bonuses don’t align well with any physical class, leaving them clustered in a narrow band of options. Bard is the most mechanically unique class in the PHB; Fighter is the least. The adventuring population skews heavily Human and Elf, which turns out to be a direct consequence of their attribute flexibility rather than player preference for those species.

The image below shows chi-squared standardized residuals for species-class combinations — red means the pairing occurs more than the marginal distributions would predict, blue means less.

<p align="center">
  <img src="/images/chisq-resid.png" width = "700" />
</p>

The code is on <a href="https://github.com/simonhansedasi/char_gen" target="_blank">GitHub</a>.
