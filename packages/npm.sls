{% from "packages/map.jinja" import packages_map with context %}

{% if 'npm' in packages_map and packages_map.npm != None %}

{# ensure npm command is installed #}
{% if packages_map.npm_install == True %}
ensure-npm-installed:
  pkg.installed:
    - name: {{ packages_map.lookup.pkgs.npm }}
{% endif %}

{# install node.js packages #}
{% for name, options in packages_map.npm.get('install', {}).items() %}
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
{% for option_name, option_value in options.get('options', {}).items() %}
    - {{ option_name }}: {{ option_value }}
{% endfor %}
{% endif %}
{% else %}
    - name: {{ name }}
{% endif %}
{% endfor %}

{# remove node.js packages #}
{% for name in packages_map.npm.get('uninstall', []) %}
npm-remove-{{ name }}:
  npm.removed:
    - name: {{ name }}
{% endfor %}

{% endif %} {# npm in packages_map #}

{# EOF #}
