---
layout: archive
title: "ai_glue"
permalink: /projects/ai_glue
author_profile: true
redirect_from:
---

<a href="https://github.com/simonhansedasi/ai_glue" target="_blank">Source on GitHub</a><br><br>

Every call an application makes to a language model has a cost, a latency, and a payload. Most teams cannot say what those add up to, which projects spend the money, or whether a prompt just carried a Social Security number to a third party. ai_glue answers those questions by sitting between the application and the model provider.

It is a governance and observability layer for the Anthropic and OpenAI APIs. In proxy mode an existing application changes one environment variable, the base URL, and nothing else. Every call is then logged with provider, model, token counts, cost, latency, project, and session. In wrapper mode a new application calls a drop-in client instead of the provider SDK.

<p align="center">
  <img src="/images/ai_glue_executive.png" width="700" alt="ai_glue executive view: spend by project, daily spend, and a risk-flag callout" />
</p>
<p align="center"><em>The executive view, from a May 2026 snapshot early in its life.</em></p>

**Policy, not just logging.** Rules live in a YAML file that is reloaded on every request, so a change takes effect without a restart. An unapproved model is blocked before the call leaves. Daily cost caps and hourly rate limits apply per project. Email addresses, phone numbers, and Social Security numbers are flagged for review rather than silently passed. Teams can be issued their own keys, which map to a project and cost cap with no code change on their side.

**One view across machines.** Four instances run on my own hardware and servers: two on a Raspberry Pi, one on the production host for <a href="/projects/rippleforge">RippleForge</a>, and one on a desktop. A parent instance merges them into a single audit view, an executive spend summary, and a per-instance breakdown. It is used on my own Claude Code traffic as well as on a production application, which is where two real bugs turned up: an aggregator that listed itself as a child and called itself in a loop, and a price table that logged several current models at zero cost.

**Agent health.** The newest piece answers a harder question than cost: is an agent still behaving the way it did when it passed its tests? Callers label each request with the agent that made it and the agent that called it. From those labels ai_glue builds a tree of agents and subagents and marks each one RED, AMBER, GREEN, or UNTESTED. The rules are plain. A blocked gate run or an error rate above 5 percent over seven days is RED. An agent running a configuration with no passing baseline, or whose production tool-call mix has drifted from the one it was tested on, is AMBER. The drift measure is total variation distance, with a threshold of 0.30 and at least 30 calls on each side. All of the status logic is pure functions with one unit test per rule.

<p align="center">
  <img src="/images/ai_glue_staging.png" width="700" alt="ai_glue agent staging page for the rippleforge project, with the RED, AMBER, GREEN status rules" />
</p>

The page above is real and not flattering. Most of those agents read UNTESTED, because no eval run has been recorded for them yet. The tool reports that plainly instead of rounding up.

**What it is not.** It has no opinion about prompts, agents, retrieval, or orchestration. It does not replace an AI stack. Its job is to make the stack visible and to enforce a few rules.

**Limits worth knowing.** Individual user tracking is a deliberate non-feature, because it would require changes on the client and defeat the one-variable pitch. The dashboard can be placed behind a shared token, and raw prompt storage can be turned off, which is how the production instance runs. PII detection is pattern-based, so it catches formatted identifiers and misses anything a regular expression cannot see.

The suite has 120 tests, all passing, and none of them need an API key.

Stack: Python, Flask, SQLite, gunicorn, Anthropic SDK, OpenAI SDK, Chart.js.
