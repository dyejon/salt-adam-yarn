{%- set settings = { } %}

{# do settings.update({ 

  ### overrides
  # 'source_url': ... ,
  # 'uid': ... ,

}) #}

{% set adam = {} %}

{% 

do adam.update({
  'source_url': settings.get('source_url', 'https://repo1.maven.org/maven2/org/bdgenomics/adam/adam-distribution/0.16.0/adam-distribution-0.16.0-bin.tar.gz'),
  'real_home_dir': settings.get('real_home_dir', '/usr/lib/adam-distribution-0.16.0'),
  'alt_home_dir': settings.get('alt_home_dir', '/usr/lib/adam'),
  'uid': settings.get('uid', 9002),
  'username': settings.get('username', 'adam'),
}) 

%}
