elastic-repo-gpg-key:
  file.managed:
    - name: etc/pki/rpm-gpg/GPG-KEY-elasticsearch
    - src: https://packages.elastic.co/GPG-KEY-elasticsearch
    - source_hash: md5=41c14e54aa0d201ae680bb34c199be98

elastic-repo:
  pkgrepo.managed:
    - humanname: Logstash
    - name: logstash
    - baseurl: http://packages.elastic.co/logstash/2.2/centos
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/GPG-KEY-elasticsearch

#elk-pkgs:
#  pkg.installed:
#    - names:
#      - logstash
#      - blah
#    - require:
#      - pkgrepo: elastic-repo
#      - file: elastic-repo-gpg-key
