---
layout: page
permalink: /publications/
title: publications
description: 
years: [Computer Graphics]
nav: true
---

<div class="publications">

{% for y in page.years %}
  <div class="row">
    <div class="col-sm-12">
      <h2 class="year">{{y}}</h2>
    </div>
  </div>
  {% bibliography -f papers -q @*[year={{y}}]* %}
{% endfor %}

</div>
