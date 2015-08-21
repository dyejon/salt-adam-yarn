include:
  - .
  - adam
  - hadoop.hdfs

{%- from 'hadoop/settings.sls' import hadoop with context %}

hdfs-refresh:
  cmd.wait:
    - name: hdfs dfsadmin -refreshNodes
    - user: adam
    - cwd: /
    - watch:
      - file: {{ hadoop.alt_config }}/dfs.hosts

hdfs-rebalance:
  cmd.wait:
    - name: hdfs balancer
    - user: adam
    - cwd: /
    - watch:
      - cmd: hdfs-refresh
