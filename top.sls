base:
  'adam_namenode:true':
    - match: grain
    - adamstack.namenode
  'adam_worker:true':
    - match: grain
    - adamstack.worker
