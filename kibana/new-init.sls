elastic-repo-key:
  file.managed:
# The location of the GPG will be different whether you are using Debian or yum based systems
# https://docs.saltstack.com/en/latest/topics/tutorials/states_pt3.html#using-grains-in-sls-modules

logstash-repo-key:
  file.managed:

elastic-repo:
  pkgrepo.managed:
**Fill this in**
https://docs.saltstack.com/en/latest/ref/states/all/salt.states.pkgrepo.html
Use https://github.com/radiantbluetechnologies/sm-rbtcloud-com/blob/master/salt/ossim-yum-repo/init.sls
as a guide for setting the c2s env

logstash-repo:
  pkgrepo.managed:

elk-packages:
  pkg.installed:
    - names:
      - elasticsearch
      - xxxxxxxx

# Most CentOS packages don't start or enable themselves automatically after a 
# reboot. You have to specifically start and enable them.
elastic-search-service:
https://docs.saltstack.com/en/latest/ref/states/all/salt.states.service.html

logstash-service:



{% set kibana_port = salt['pillar.get']('kibana:httpport', '8080') %}
{% set elastic_port = salt['pillar.get']('elasticsearch:httpport', '9200') %}
{% set server_name = salt['pillar.get']('kibana:site_name', 'kibana.cdp') %}
{% set wwwhome = salt['pillar.get']('kibana:wwwhome', '/var/www') %}
{% set kibana_wwwroot = wwwhome + '/' + server_name + '/' %}
{% set elastic_htpasswd_file = '/etc/nginx/elastic_passwd' %}
{% set bind_host = salt['pillar.get']('kibana:bind_host', '127.0.0.1') %}


