# remove own localhost entry
{{ grains['fqdn'] }}:
  host.absent:
    - ip: 127.0.0.1

# add specified hosts entries
{% for server, ips in salt.mine.get('*', 'network.ip_addrs', expr_form='glob').items() %}
{% for val in ips -%}
{{ server|replace('-','_') }}_host:
  host.present:
    - ip: {{ val }}
    - names:
      - {{ salt['helpers.re_replace']('\..*$', '', server) }}
      - {{ server }}
{% endfor %}
{% endfor %}

# vim: set ts=2 sw=2 expandtab:
