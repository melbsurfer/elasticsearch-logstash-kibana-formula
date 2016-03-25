elk-repo-gpg-key:
  file.managed:
    - name: /etc/pki/rpm-gpg/GPG-KEY-elasticsearch
    - source: https://packages.elastic.co/GPG-KEY-elasticsearch
    - source_hash: md5=41c14e54aa0d201ae680bb34c199be98

elastic-repo:
  pkgrepo.managed:
    - humanname: Elasticsearch
    - name: elasticsearch
    - baseurl: https://packages.elastic.co/elasticsearch/2.x/centos
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/GPG-KEY-elasticsearch

logstash-repo:
  pkgrepo.managed:
    - humanname: Logstash
    - name: logstash
    - baseurl: http://packages.elastic.co/logstash/2.2/centos
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

# kibana:
#   archive.extracted:
#     - name: 
#     - source: https://download.elasticsearch.org/kibana/kibana/kibana-3.0.1.tar.gz
#     - archive_format: tar
#     - tar_options: xf
