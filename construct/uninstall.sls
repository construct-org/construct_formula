{% from "construct/map.jinja" import construct with context %}
{% set install_dir = construct.install_dir %}


Uninstall Construct:
  file.absent:
    - name: {{ install_dir }}
