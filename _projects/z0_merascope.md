---
layout: archive
title: "Merascope"
permalink: /projects/merascope
author_profile: true
redirect_from:
---

<a href="https://merascope.com" target="_blank">Live at merascope.com</a><br><br>

Merascope scores every ZIP code tabulation area in 48 states on 23 indicators of capacity and constraint, so that a siting decision can be argued from evidence instead of from the single variable that happened to be cheapest. It is the successor to the <a href="/projects/datacenter-siting">Washington data center analysis</a>, rebuilt to cover 48 states instead of one.

The same inventory is reweighted for different purposes. A data center cares about transmission and water. A battery storage project cares about different things. Two hard gates disqualify a site regardless of weights, so a preference cannot talk its way past a physical or legal limit.

Three kinds of user work on the same records with different permissions. Builders screen sites. Stewards, the lead regulatory agencies, run a docket, a case file, and a conditions negotiation, and can export the evidentiary record. Co-parties such as tribes, counties, and utilities see a filtered docket and propose conditions. Access rules are written into the schema as constraints instead of left to convention, and every action is recorded in an append-only event log.

I am the only engineer. The backend is PostgreSQL 16 behind Flask and gunicorn, with a pytest suite that runs in GitHub Actions against a live Postgres container before anything deploys. Documents are served as short-lived presigned URLs from S3-compatible object storage.

Stack: Python, Flask, PostgreSQL, geopandas, boto3, GitHub Actions.
