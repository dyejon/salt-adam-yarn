{%- from 'adam/settings.sls' import adam with context %}
{%- from 'adam/user_macro.sls' import user_macro with context %}

{{ user_macro(adam['username'], adam['uid']) }}

include: 
  - sun-java
  - sun-java.env 

unpack-adam-dist:
  cmd.run:
    - name: curl '{{ adam['source_url'] }}' | tar xz --no-same-owner
    - cwd: /usr/lib
    - unless: test -d {{ adam['real_home_dir'] }}
  
adam-home-link:
  alternatives.install:
    - link: {{ adam['alt_home_dir'] }}
    - path: {{ adam['real_home_dir'] }}
    - priority: 30

/etc/profile.d/adam.sh:
  file.managed:
    - source: salt://adam/files/adam.sh.jinja
    - template: jinja
    - mode: 755
    - user: root
    - group: root
    - context:
        alt_home_dir: {{ adam['alt_home_dir'] }}
