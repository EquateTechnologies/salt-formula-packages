{% from "packages/map.jinja" import packages_map with context %}

{# install packages #}
{% for name, options in packages_map.install.items() %}
packages-install-{{ name }}:
  pkg.installed:
{% if options.name %}
    - name: {{ options.name }}
{% else %}
    - name: {{ name }}
{% endif %}
{% if options.version %}
    - version: {{ options.version }}
{% endif %}
{% endfor %}

{# uninstall packages #}
{% for name in packages_map.uninstall %}
packages-uninstall-{{ name }}:
  pkg.removed:
    - name: {{ name }}
{% endfor %}
