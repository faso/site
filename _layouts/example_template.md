---
layout: example
---

{% capture content_html %}
    {% include {{page.contentHTML}} %}
{% endcapture %}

{% capture content_js %}
    {% include {{page.contentJS}} %}
{% endcapture %}

{% capture content_css %}
    {% include {{page.contentCSS}} %}
{% endcapture %}

{% for include in page.includes %}
    {% include {{include}} %}
{% endfor %}