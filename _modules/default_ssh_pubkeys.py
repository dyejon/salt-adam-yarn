#!/usr/bin/env python2

"""
get default ssh key pubkey and fingerprint
"""

import os
import base64
import hashlib
import itertools

import salt.utils


## supporting functions

def ssh_fingerprint(pubkey):
    """ convert ssh public key to fingerprint """
    key = base64.b64decode(pubkey.strip().split()[1].encode('ascii'))
    fp_plain = hashlib.md5(key).hexdigest()
    return ':'.join(a+b for a,b in zip(fp_plain[::2], fp_plain[1::2]))


## module functions

def items(user=None):
    """ return default ssh host public key and fingerprint """
    user = user or 'root'

    pubkeys = {}
    hosts = [ h for h in itertools.chain(
                    [__salt__.grains.get('id')],
                    [__salt__.grains.get('id').split('.')[0]],
                    __salt__.network.ip_addrs(),
                )
            ]

    user_keys = __salt__.ssh.user_keys(user=user) or {}

    assert len(user_keys) == 1

    for key, val in user_keys.values()[0].items():
        if key.endswith('.pub'):
            name = key[:-4]
            pubkeys[name] = dict(pubkey=val, fingerprint=ssh_fingerprint(val), enc=val.strip().split()[0], hosts=hosts)
    
    return pubkeys


# vim: set ts=4 sw=4 expandtab:
