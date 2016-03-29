elk-repo-gpg-key:
  file.managed:
    - name: /etc/pki/rpm-gpg/GPG-KEY-elasticsearch
    - source: {{ pillar['elk_gpg_key_url'] }}
    - source_hash: {{ pillar['elk_gpg_key_hash']}}

elastic-repo:
  pkgrepo.managed:
    - humanname: Elasticsearch
    - name: elasticsearch
    - baseurl: {{ pillar['elastic_repo_url'] }}
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/GPG-KEY-elasticsearch

logstash-repo:
  pkgrepo.managed:
    - humanname: Logstash
    - name: logstash
    - baseurl: {{ pillar['logstash_repo_url'] }}
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/GPG-KEY-elasticsearch

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
      - filebeat: https://download.elastic.co/beats/filebeat/filebeat-1.1.2-x86_64.rpm
    - require:
      - file: elk-repo-gpg-key

kibana:
  archive.extracted:
    - name: /tmp/kibana
    - source: {{ pillar['kibana_download_url'] }}
    - source_hash: md5=bb52377494d4cd8aef0885f76f9a7b2e
    - archive_format: tar
    - tar_options: xf
