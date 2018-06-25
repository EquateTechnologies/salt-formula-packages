{% from "packages/map.jinja" import packages_map with context %}

{% if 'gem' in packages_map and packages_map.gem != None %}

{# ensure gem command is installed #}
{% if packages_map.gem_install == True %}
ensure-gem-installed:
  pkg.installed:
    - name: {{ packages_map.lookup.pkgs.gem }}
{% endif %}

{# install ruby gems #}
{% for name, options in packages_map.gem.get('install', {}).items() %}
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
{% else %}
    - name: {{ name }}
{% endif %}
{% endfor %}

{# uninstall ruby gems #}
{% for name in packages_map.gem.get('uninstall', []) %}
gem-remove-{{ name }}:
  gem.removed:
    - name: {{ name }}
{% endfor %}

{% endif %} {# pip in packages_map #}

{# EOF #}
