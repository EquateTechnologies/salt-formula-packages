{% from "packages/map.jinja" import packages_map with context %}

{# install packages #}
{% for name, options in packages_map.get('install', {}).items() %}
packages-install-{{ name }}:
  pkg.installed:
{% if options != None %}
{% if options.name %}
    - name: {{ options.name }}
{% else %}
    - name: {{ name }}
{% endif %}
{% if options.version %}
    - version: {{ options.version }}
{% endif %}
{% for option_name, option_value in options.get('options', {}).items() %}
    - {{ option_name }}: {{ option_value }}
{% endfor %}
{% else %}
    - name: {{ name }}
{% endif %}
{% endfor %}

{# uninstall packages #}
{% for name in packages_map.get('uninstall', []) %}
packages-uninstall-{{ name }}:
  pkg.removed:
    - name: {{ name }}
{% endfor %}
