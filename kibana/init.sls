{% set elk_gpg_key_url = salt['pillar.get']('elk_gpg_key_url', 'https://packages.elastic.co/GPG-KEY-elasticsearch') %}
{% set logstash_repo_url = salt['pillar.get']('logstash_repo_url', 'http://packages.elastic.co/logstash/2.2/centos') %}
{% set elastic_repo_url = salt['pillar.get']('elastic_repo_url', 'https://packages.elastic.co/elasticsearch/2.x/centos') %}
{% set kibana_download_url = salt['pillar.get']('kibana_download_url', 'https://download.elastic.co/kibana/kibana/kibana-4.4.1-linux-x64.tar.gz') %}
{% set filebeat_download_url = salt['pillar.get']('filebeat_download_url',' https://download.elastic.co/beats/filebeat/filebeat-1.1.2-x86_64.rpm') %} 

elk-repo-gpg-key:
  file.managed:
    - name: /etc/pki/rpm-gpg/GPG-KEY-elasticsearch
    - source: {{ elk_gpg_key_url }}
    - source_hash: md5=41c14e54aa0d201ae680bb34c199be98

elastic-repo:
  pkgrepo.managed:
    - humanname: Elasticsearch
    - name: elasticsearch
    - baseurl: {{ elastic_repo_url }}
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/GPG-KEY-elasticsearch

logstash-repo:
  pkgrepo.managed:
    - humanname: Logstash
    - name: logstash
    - baseurl: {{ logstash_repo_url }}
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/GPG-KEY-elasticsearch
    {% if pillar['c2senv'] == True %}
    {% if "https" in logstash_repo_url %}
    - proxy: {{ pillar['proxies']['https'] }}
    {% else %}
    - proxy: {{ pillar['proxies']['http'] }}
    {% endif %}
    {% endif %}

elk-pkgs:
 pkg.installed:
   - pkgs:
     - elasticsearch
     - logstash
   - require:
     - pkgrepo: elastic-repo
     - pkgrepo: logstash-repo
     - file: elk-repo-gpg-key

filebeat-pkg:
  pkg.installed:
    - sources:
      - filebeat: {{ filebeat_download_url }}
    - require:
      - file: elk-repo-gpg-key

kibana:
  archive.extracted:
    - name: /tmp/kibana
    - source: {{ kibana_download_url }}
    - source_hash: md5=bb52377494d4cd8aef0885f76f9a7b2e
    - archive_format: tar
    - tar_options: xf

