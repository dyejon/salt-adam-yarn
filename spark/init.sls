{%- from 'spark/settings.sls' import spark with context %}
{%- from 'spark/user_macro.sls' import user_macro with context %}

{{ user_macro(spark['username'], spark['uid']) }}

include: 
  - ntp.server
  - sun-java
  - sun-java.env 

unpack-spark-dist:
  cmd.run:
    - name: curl '{{ spark['source_url'] }}' | tar xz --no-same-owner
    - cwd: /usr/lib
    - unless: test -d {{ spark['real_home_dir'] }}/lib
  
spark-home-link:
  alternatives.install:
    - link: {{ spark['alt_home_dir'] }}
    - path: {{ spark['real_home_dir'] }}
    - priority: 30

/etc/profile.d/spark.sh:
  file.managed:
    - source: salt://spark/files/spark.sh.jinja
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - context:
        alt_home_dir: {{ spark['alt_home_dir'] }}
