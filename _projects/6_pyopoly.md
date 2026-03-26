---
layout: archive
title: "Pyopoly"
permalink: /projects/pyopoly
author_profile: true
redirect_from:
---
Monopoly has always been a fun way to kill time. First as a child playing star wars monopoly with my family, then later I made a board and dice from paper to play with fellow recruits in basic training. While on paternity leave I began writing a python based command line interface version of monopoly.
<p align="center">
  <img src="/images/pyopoly.png" width = "700" />
</p>

The board and properties are defined as classes, with NumPy for dice. The full mechanics are implemented: buying properties, building houses and hotels, paying rent, drawing Chance and Community Chest cards, going to jail. CPU opponents make automated buy and build decisions. The terminal output is colorized. It ends when someone goes bankrupt — unlike our current housing market, which does not.

The code is on <a href="https://github.com/simonhansedasi/pyopoly" target="_blank">GitHub</a>.
