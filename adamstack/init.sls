curl:
  pkg.installed

include:
  - meshssh
  - hostsfile
  - hostsfile.hostname
  - ntp.server
  - sun-java
  - sun-java.env 
  - hadoop
  - hadoop.hdfs
  - hadoop.yarn
  - spark.yarn
