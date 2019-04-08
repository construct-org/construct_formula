{% from "construct/map.jinja" import construct with context %}

{% set install_dir = construct.install_dir %}
{% set latest_dir = construct.install_dir + "\\latest" %}
{% set bin_dir  = construct.install_dir + '\\bin' %}
{% set env_dir = construct.install_dir + "\\" + construct.version %}
{% set py_exe = construct.python_exe %}
{% set config = construct.config %}
{% set pip_install = construct.pip_install + "@" + construct.version %}


Ensure Construct Install Directory Exists:
  file.directory:
    - name: {{ install_dir }}


Unlink latest Virtualenv:
  file.absent:
    - name: {{ latest_dir }}


Ensure Virtualenv Installed:
  pip.installed:
    - name: virtualenv
    - upgrade: True


Ensure Virtualenv Exists:
  virtualenv.managed:
    - name: {{ env_dir }}
    - python: {{ py_exe }}
    - pip_upgrade: True


Ensure Construct Bin Directory Exists:
  file.directory:
    - name: {{ bin_dir }}


Link latest Virtualenv:
  file.symlink:
    - name: {{ latest_dir }}
    - target: {{ env_dir }}


Unset Construct latest bin PATH:
  win_path.absent:
    - names:
      - '%construct_latest%'
      - '%CONSTRUCT_BIN%'
      - '{{ latest_dir }}'
      - '{{ bin_dir }}'


Set Environment Variables:
  cmd.run:
    - names:
      - SETX /M CONSTRUCT_CONFIG "{{ config }}"
      - SETX /M CONSTRUCT_BIN "{{ bin_dir }}"
  win_path.exists:
    - name: {{ bin_dir }}
    - index: 0
  module.run:
    - name: win_path.rehash


Ensure Construct Installed:
  pip.installed:
    - ignore_installed: True
    - name: {{ pip_install }}
    - bin_env: {{ env_dir }}


Construct CLI cmd:
  file.managed:
    - name: {{ bin_dir }}\construct.bat
    - source: salt://construct/files/construct.bat
    - replace: True
    - template: jinja
    - defaults:
        latest_dir: {{ latest_dir }}


Construct CLI powershell:
  file.managed:
    - name: {{ bin_dir }}\construct.ps1
    - source: salt://construct/files/construct.ps1
    - replace: True
    - template: jinja
    - defaults:
        latest_dir: {{ latest_dir }}


Construct CLI cmd - Alias:
  file.managed:
    - name: {{ bin_dir }}\cons.bat
    - source: salt://construct/files/construct.bat
    - replace: True
    - template: jinja
    - defaults:
        latest_dir: {{ latest_dir }}


Construct CLI powershell - Alias:
  file.managed:
    - name: {{ bin_dir }}\cons.ps1
    - source: salt://construct/files/construct.ps1
    - replace: True
    - template: jinja
    - defaults:
        latest_dir: {{ latest_dir }}
