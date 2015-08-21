{%- set settings = { } %}

{# do settings.update({ 

  ### overrides
  # 'source_url': ... ,
  # 'uid': ... ,

}) #}

{% set spark = {} %}

{% 

do spark.update({
  'source_url': settings.get('source_url', 'http://mirror.reverse.net/pub/apache/spark/spark-1.4.1/spark-1.4.1-bin-hadoop2.4.tgz'),
  'real_home_dir': settings.get('real_home_dir', '/usr/lib/spark-1.4.1-bin-hadoop2.4'),
  'alt_home_dir': settings.get('alt_home_dir', '/usr/lib/spark'),
  'uid': settings.get('uid', 9001),
  'username': settings.get('username', 'spark'),
}) 

%}
