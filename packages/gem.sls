{% from "packages/map.jinja" import packages_map with context %}

{# install ruby gems #}
{% for name, options in packages_map.get('gem:install', {}).items() %}
gem-install-{{ name }}:
  gem.installed:
{% if options != None %}
{% if options.name %}
    - name: {{ options.name }}
{% else %}
    - name: {{ name }}
{% endif %}
{% if options.version %}
    - version: {{ options.version }}
{% else %}
    - name: {{ name }}
{% endif %}
{% for option_name, option_value in options.get('options', {}).items() %}
    - {{ option_name }}: {{ option_value }}
{% endfor %}
{% endif %}
{% endfor %}

{# uninstall gems #}
{% for name in packages_map.get('gem:uninstall', []) %}
gem-remove-{{ name }}:
  gem.removed:
    - name: {{ name }}
{% endfor %}
