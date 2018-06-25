{% from "packages/map.jinja" import packages_map with context %}

{# install python modules #}
{% for name, options in packages_map.get('pip:install', {}).items() %}
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
{% for option_name, option_value in options.get('options', {}).items() %}
    - {{ option_name }}: {{ option_value }}
{% endfor %}
{% endif %}
{% else %}
    - name: {{ name }}
{% endif %}
{% endfor %}

{# uninstall pips #}
{% for name in packages_map.get('pip:uninstall', []) %}
pip-remove-{{ name }}:
  pip_state.removed:
    - name: {{ name }}
{% endfor %}
