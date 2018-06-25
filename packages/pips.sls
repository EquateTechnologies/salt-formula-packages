{% from "packages/map.jinja" import packages_map with context %}

{# install python pips #}
{% for name, options in packages_map.get('pips:install', {}).items() %}
pip-install-{{ name }}:
  pip_state.installed:
{% if options != None %}
{% if options.name %}
{% if options.version %}
    - name: {{ options.name }} {{ options.version }}
{% else %}
    - name: {{ options.name }}
{% endif %}
{% else %}
{% if options.version %}
    - name: {{ name }} {{ options.version }}
{% else %}
    - name: {{ name }}
{% endif %}
{% endif %}
{% endfor %}

{# uninstall pips #}
{% for name in packages_map.get('pips:uninstall', []) %}
pip-remove-{{ name }}:
  pip_state.removed:
    - name: {{ name }}
{% endfor %}
