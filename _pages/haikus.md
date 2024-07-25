---
layout: archive
title: "Haikus"
permalink: /haikus/
author_profile: true
---
{% include base_path %}

{% for post in site.haikus reversed %}
  {% include archive-single.html %}
{% endfor %}
