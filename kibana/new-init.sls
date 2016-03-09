elk-repo-key:
  file.managed:
# The location of the GPG will be different whether you are using Debian or yum based systems
# https://docs.saltstack.com/en/latest/topics/tutorials/states_pt3.html#using-grains-in-sls-modules

elk-repo:
  pkgrepo.managed:

elk-packages:
  pkg.installed:
    - names:
      - elasticsearch


{% set kibana_port = salt['pillar.get']('kibana:httpport', '8080') %}
{% set elastic_port = salt['pillar.get']('elasticsearch:httpport', '9200') %}
{% set server_name = salt['pillar.get']('kibana:site_name', 'kibana.cdp') %}
{% set wwwhome = salt['pillar.get']('kibana:wwwhome', '/var/www') %}
{% set kibana_wwwroot = wwwhome + '/' + server_name + '/' %}
{% set elastic_htpasswd_file = '/etc/nginx/elastic_passwd' %}
{% set bind_host = salt['pillar.get']('kibana:bind_host', '127.0.0.1') %}


