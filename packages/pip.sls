{% from "packages/map.jinja" import packages_map with context %}

{% if 'pip' in packages_map and packages_map.pip != None %}

{# ensure pip command is installed #}
{% if packages_map.pip_install == True %}
ensure-pip-installed:
  pkg.installed:
    - name: {{ packages_map.lookup.pkgs.pip }}
{% endif %}

{# install python modules #}
{% for name, options in packages_map.pip.get('install', {}).items() %}
pip-install-{{ name }}:
  pip.installed:
{% if options != None %}
{% if options.name %}
{% if options.version %}
    - name: {{ options.name }} {{ options.version }}
{% else %} {# if options.version #}
    - name: {{ options.name }}
{% endif %} {# if options.version #}
{% else %} {# if options.name #}
{% if options.version %}
    - name: {{ name }} {{ options.version }}
{% else %} {# if options.version #}
    - name: {{ name }}
{% endif %} {# if options.version #}
{% endif %} {# if options.name #}
{% for option_name, option_value in options.get('options', {}).items() %}
    - {{ option_name }}: {{ option_value }}
{% endfor %} {# options.options #}
{% else %} {# if options == None #}
    - name: {{ name }}
{% endif %} {# if options != None #}
{% endfor %} {# packages:pip:install #}

{# remove python modules #}
{% for name in packages_map.get('pip:uninstall', []) %}
pip-remove-{{ name }}:
  pip_state.removed:
    - name: {{ name }}
{% endfor %}

{% endif %} {# pip in packages_map #}

{# EOF #}
