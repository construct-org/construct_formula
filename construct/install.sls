
include:
{% if grains['os'] == 'Windows' %}
  - construct._install_win
{% elif grains['os'] == 'MacOS' %}
  - construct._install_mac
{% else %}
  - construct._install_linux
{% endif %}
