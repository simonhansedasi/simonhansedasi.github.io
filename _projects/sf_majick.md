---
layout: archive
title: "sf_majick"
permalink: /projects/sf_majick
author_profile: true
redirect_from:
---

I wanted a model of a sales organization that had reps in it.

Not a conversion funnel — those exist — but something with agents who make decisions, develop opinions about their accounts, get burned out, and respond to organizational structure. The interesting question isn't what the average conversion rate is; it's what conditions produce a particular distribution of outcomes, and what levers actually move it.

**sf_majick** is a fully parameterized agent-based simulator for B2B sales orgs. Four rep archetypes — Closer, Nurturer, Grinder, Scattered — each with distinct personality traits governing action affinity, distraction rates, and burnout thresholds. Nine micro-actions (email, call, meeting, proposal, internal prep, and four others) carry attention cost and sentiment effects; macro transitions (lead conversion, stage advancement, close/lost) fire stochastically with probabilities modulated by sentiment, momentum, and rep behavior. Reps accumulate workload stress via an end-of-day burnout model; stress above archetype threshold craters available attention and increments days burned out. Every entity carries a sentiment state that decays under neglect and updates with each interaction.

The structural variable of most interest is the requirement gate: whether a micro-action must be completed before a stage can advance (AND logic), or whether completing any one of several qualifies (OR logic). AND-gate configurations produce low stage-advance rates and concentrated drop-off; OR-gate configurations produce higher throughput with a different distribution of deal stall. The figure below shows the funnel shapes each produces.

<p align="center">
  <img src="/images/sf_majick_gates.png" width="700" />
</p>

The calibration layer (`OrgCalibrator`) back-fits simulation parameters to a Salesforce SOQL export: win rate, cycle time, and stage distribution determine the probability fields; revenue distributions are fitted from deal-size data. The result is an `OrgConfig` whose simulated org behaviorally matches the real one. Experiments run against this baseline using `ExperimentRunner` — N Monte Carlo iterations per scenario, with OLS-adjusted action effect coefficients that control for stage, rep, and outcome before attributing sentiment deltas to specific micro-actions. This separates actions that move deals from actions that merely correlate with deals that were going to move anyway.

The web interface runs on a Raspberry Pi: a five-tab Flask app for org configuration, calibration diagnostics, and a Salesforce CSV drop that auto-fits and saves a calibration file. Simulation runs execute locally; the Pi's ARM CPU is 10–30× too slow for the Python engine.

The code is on <a href="https://github.com/simonhansedasi/sf_majick" target="_blank">GitHub</a>.
