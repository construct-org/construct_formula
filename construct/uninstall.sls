{% from "construct/map.jinja" import construct with context %}
{% set install_dir = construct.install_dir %}


Uninstall Construct:
  file.absent:
    - name: {{ install_dir }}
{% if grains['os'] == 'Windows' %}
  cmd.run:
    - names:
      - REG delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /F /V CONSTRUCT_CONFIG
      - REG delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /F /V CONSTRUCT_LATEST
  win_path.absent:
    - name: {{ install_dir }}
  module.run:
    - name: win_path.rehash
{% endif %}
