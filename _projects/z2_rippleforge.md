---
layout: archive
title: "RippleForge"
permalink: /projects/rippleforge
author_profile: true
redirect_from:
---

<a href="https://rippleforge.gg" target="_blank">Live at rippleforge.gg</a> &middot; <a href="https://rippleforge.gg/demo/" target="_blank">Try the demo</a><br><br>

Log one event and every connected character, faction, and place feels it. RippleForge is a causality engine for narrative: a relationship graph in which an event propagates to allies, inverts for rivals, and compounds across sessions. It was built for tabletop game masters, and it works for any story in which what happens to one person matters to everyone else.

The AI is a referee, not a storyteller. It does not invent the world. It reads what a person has recorded, works out who is affected and in which direction, and proposes consequences for that person to accept or reject.

<p align="center">
  <img src="/images/rippleforge_ripples.png" width="700" alt="RippleForge ripple chains: one captured ledger propagating to three connected figures" />
</p>

**The pipeline.** Raw session notes go in. A first model pass extracts discrete events, matches each to known entities, and assigns polarity and intensity. A second pass checks the result for consistency against the existing world. A person reviews the proposals and commits them explicitly. Nothing reaches the world state without that last step.

**The chat co-pilot.** A game master can correct a drafted proposal in conversation instead of editing fields by hand. It is a tool-use agent loop written directly against the Anthropic API, with no orchestration framework. The design constraint is that no tool may write to campaign data. Only the existing human-gated commit route can. A test asserts that a world file is byte-for-byte identical before and after a chat exchange, so the constraint is enforced rather than promised.

<p align="center">
  <img src="/images/rippleforge_world.png" width="700" alt="RippleForge world graph with a time-travel slider and timeline forking" />
</p>

**Time travel and forking.** The world graph can be rewound to any session. A fork creates an alternate branch from that point, and the original timeline stays intact, so a what-if costs nothing.

**How it is kept honest.** The suite has 81 tests, all passing. The chat agent also has a staging gate: the current configuration is run repeatedly against a recorded baseline, and the result is PASS or BLOCK before a change ships. Results post to <a href="/projects/ai_glue">ai_glue</a>, which shows agent health as RED, AMBER, GREEN, or UNTESTED. Every model call from the production app routes through ai_glue, so cost, latency, and errors are logged per call.

The public demo is a five-session frontier mining campaign called The Ashcroft Vein. Changes made there reset every 30 minutes.

Stack: Python, Flask, gunicorn, nginx, Cytoscape.js, Anthropic API (Claude Haiku), pytest. Billing is built and switched off.
