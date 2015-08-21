{% macro user_macro(username, uid) -%}
{%- set userhome='/home/'+username %}
{{ username }}:
  group.present:
    - gid: {{ uid }}
  user.present:
    - uid: {{ uid }}
    - gid: {{ uid }}
    - home: {{ userhome }}
    - shell: /bin/bash
    - groups: [ {{ username }} ]
    - require:
      - group: {{ username }}

{{ userhome }}/.ssh:
  file.directory:
    - user: {{ username }}
    - group: {{ username }}
    - mode: 744
    - require:
      - user: {{ username }}
      - group: {{ username }}

{{ username }}_private_key:
  file.managed:
    - name: {{ userhome }}/.ssh/id_dsa
    - user: {{ username }}
    - group: {{ username }}
    - mode: 600
    - source: salt://spark/files/dsa-{{ username }}
    - require:
      - file: {{ userhome }}/.ssh

{{ username }}_public_key:
  file.managed:
    - name: {{ userhome }}/.ssh/id_dsa.pub
    - user: {{ username }}
    - group: {{ username }}
    - mode: 644
    - source: salt://spark/files/dsa-{{ username }}.pub
    - require:
      - file: {{ username }}_private_key

ssh_dss_{{ username }}:
  ssh_auth.present:
    - user: {{ username }}
    - source: salt://spark/files/dsa-{{ username }}.pub
    - require:
      - file: {{ username }}_private_key

{{ userhome }}/.ssh/config:
  file.managed:
    - source: salt://spark/conf/ssh/ssh_config
    - user: {{ username }}
    - group: {{ username }}
    - mode: 644
    - require:
      - file: {{ userhome }}/.ssh

/etc/security/limits.d/99-{{username}}.conf:
  file.managed:
    - mode: 644
    - user: root
    - contents: |
        {{username}} soft nofile 65536
        {{username}} hard nofile 65536
        {{username}} soft nproc 65536
        {{username}} hard nproc 65536

{%- endmacro %}

