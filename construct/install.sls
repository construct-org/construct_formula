{% from "construct/map.jinja" import construct with context %}

{% set install_dir = construct.install_dir %}
{% set py_exe = construct.python_exe %}
{% set config = construct.config %}
{% set version = construct.version %}
{% set git_repo = construct.git_repo %}
{% set construct_setup = salt.temp.dir() %}
{% set extra_opts = "" %}
{% if version != -1 %}
  {% set extra_opts = '--version=' + version %}
{% endif %}


Download construct_setup:
  cmd.run:
    - name: git clone {{ git_repo }} {{ construct_setup }}

Install construct:
{% if grains['os'] == 'Windows' %}
  cmd.run:
    - names:
      - python install.py  --ignore-prompts --where={{ install_dir }} --python={{ py_exe }} --config=config {{ extra_opts }}
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
