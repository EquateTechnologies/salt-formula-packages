{% from "packages/map.jinja" import packages_map with context %}

{# install node.js packages #}
{% for name, options in packages_map.get('npm:install', {}).items() %}
npm-install-{{ name }}:
  npm.installed:
{% if options != None %}
{% if options.name %}
{% if options.version %}
    - name: {{ options.name }}{{ options.version }}
{% else %}
    - name: {{ options.name }}
{% endif %}
{% else %}
{% if options.version %}
    - name: {{ name }}{{ options.version }}
{% else %}
    - name: {{ name }}
{% endif %}
{% endif %}
{% endif %}

{# uninstall gems #}
{% for name in packages_map.get('npm:uninstall', []) %}
npm-remove-{{ name }}:
  npm.removed:
    - name: {{ name }}
{% endfor %}
