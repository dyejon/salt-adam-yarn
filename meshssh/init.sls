include :
  - meshhosts

# generate ec 25519 (preferred), ecdsa, and rsa pubkeys
{% for enc in ('ed25519', 'ecdsa', 'rsa') %}
generate_ssh_key_{{ enc }}:
  cmd.run:
    - name: ssh-keygen -q -N '' -f ~/.ssh/id_{{ enc }}
    - user: root
    - unless: test -f ~/.ssh/id_{{ enc }}
{% endfor %}

# distribute authorized keys and accept fingerprints in known hosts
{% for server, keys in salt.mine.get('*', 'default_ssh_pubkeys.items', expr_form='glob').items() %}
{% for keyname, val in keys.items() -%}
{{ server|replace('-','_') }}_{{ keyname }}_ssh_authkey:
  ssh_auth.present:
    - user: root
    - enc: {{ val['enc'] }}
    - name: {{ val['pubkey'] }}

{{ server|replace('-','_') }}_{{ keyname }}_ssh_knownhost:
  ssh_known_hosts.present:
    - require: 
      - host: {{ server|replace('-','_') }}_host
    - user: root
    - enc: {{ val['enc'] }}
    - names:
{% for host in val['hosts'] %}
      - {{ host }}
{% endfor %}
{% endfor %}
{% endfor %}

# vim: set ts=2 sw=2 expandtab:
