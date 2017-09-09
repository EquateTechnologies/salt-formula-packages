{% from "packages/map.jinja" import packages_map with context %}

{% for name, options in packages_map.install.items() %}
{{ name }}:
  pkg.installed:
{% if options.name %}
    - name: {{ options.name }}
{% endif %}
{% if options.version %}
    - version: {{ options.version }}
{% endif %}
{% endfor %}
