{% from "construct/map.jinja" import construct with context %}

{% set install_dir = construct.install_dir %}
{% set py_exe = construct.python_exe %}
{% set config = construct.config %}
{% set version = construct.version %}
{% set git_repo = construct.git_repo %}
{% set git_exe = construct.git_exe %}
{% set construct_setup = salt.temp.dir() %}
{% set extra_opts = "" %}
{% if version != -1 %}
  {% set extra_opts = '--version=' + version %}
{% endif %}


Download construct_setup:
  cmd.run:
    - name: git clone {{ git_repo }} {{ construct_setup }}

{% if grains['os'] == 'Windows' %}
Ensure Python Installed:
  pkg.installed:
    - name: python2_x64

Ensure Pip installed:
  file.managed:
    - name: 'C:\tmp\get-pip.py'
    - source: https://bootstrap.pypa.io/get-pip.py
    - source_hash: 6f489c199cb5be8a4b84c6bd7ad6e051
  cmd.run:
    - name:
      - '{{ py_exe }} C:\tmp\get-pip.py'

'C:\Python27':
  win_path.exists:
    - index: 0

'C:\Python27\Scripts':
  win_path.exists:
    - index: 0

Ensure Git Installed:
  pkg.installed:
    - name: git

'C:\Program Files\Git\bin':
  win_path.exists:
    - index: 0

'C:\Program Files\Git':
  win_path.exists:
    - index: 0
  module.run:
    - name: win_path.rehash

Refresh Environ:
  module.run:
    - name: win_path.rehash

{% endif %}

Install construct:
{% if grains['os'] == 'Windows' %}
  cmd.run:
    - names:
      - {{ py_exe }} install.py  --ignore-prompts --where={{ install_dir }} --python={{ py_exe }} --config=config {{ extra_opts }}
      - SETX /M CONSTRUCT_CONFIG "{{ config }}"
    - cwd: {{ construct_setup }}
  win_path.exists:
    - name: {{ install_dir }}
    - index: 0
  module.run:
    - name: win_path.rehash
{% else %}
  cmd.run:
    - name: install.py  --ignore-prompts --where={{ install_dir }} --python={{ py_exe }} --config=config {{ extra_opts }}
    - cwd: {{ construct_setup }}
{% endif %}
