hadoop:
  version: apache-2.5.2
  targeting_method: grain
  config:
    directory: /etc/hadoop/conf
    core-site:
      io.native.lib.available:
        value: true
      io.file.buffer.size:
        value: 65536
      fs.trash.interval:
        value: 60

hdfs:
  namenode_target: "adam_namenode:true"
  datanode_target: "adam_worker:true"
  config:
    namenode_port: 8020
    namenode_http_port: 50070
    secondarynamenode_http_port: 50090
    replication: 2
    hdfs-site:
      dfs.permission:
        value: false
      dfs.durable.sync:
        value: true
      dfs.datanode.synconclose:
        value: true
      dfs.permissions.superusergroup:
        value: adam

yarn:
  resourcemanager_target: "adam_namenode:true"
  nodemanager_target:     "adam_worker:true"
  config:
    yarn-site:
      yarn.nodemanager.resource.memory-mb:
        value: 7680

mapred:
  jobtracker_target: "adam_namenode:true"
  tasktracker_target: "adam_worker:true"
  config:
    jobtracker_port: 9001
    jobtracker_http_port: 50030
    jobhistory_port: 10020
    jobhistory_webapp_port: 19888
    history_dir: /mr-history
    mapred-site: 
      mapred.map.memory.mb:
        value: 1536
      mapred.map.java.opts:
        value: -Xmx1024M
      mapred.reduce.memory.mb:
        value: 3072
      mapred.reduce.java.opts:
        value: -Xmx1024m
      mapred.task.io.sort.mb:
        value: 512
      mapred.task.io.sort.factor:
        value: 100
      mapred.reduce.shuffle.parallelcopies:
        value: 50

mine_functions:
  network.interfaces: []
  grains.items: []
