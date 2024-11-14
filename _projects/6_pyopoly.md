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

I define the board and properties as different classes, and the board is populated with properties with defined attributes. A numpy random number generator is used to roll dice and internal logic moves the player's piece. Rent is automatically deducted and if the property is unowned there is an option to buy it. Trading is not yet implemented, nor is game end. It basically advances around the board paying rent back and forth with no end in sight, much like our current housing market.
