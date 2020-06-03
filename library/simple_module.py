#!/usr/bin/python
# coding: utf-8
'''
A simple Ansible module based on Hello World example from
`Custom Ansible Module <http://blog.toast38coza.me/custom-ansible-module-hello-world/>`_.
'''

from ansible.module_utils.basic import AnsibleModule

ANSIBLE_METADATA = {
    'metadata_version': '1.0',
    'status': ['preview'],
    'supported_by': 'community'
}

DOCUMENTATION = '''
---
module: simple_module
version_added: 2.1
short_description: Print hello world
description:
    - A simple example of an Ansible module to print a "hello world" message.
options:
    - name:
        description:
            - name to print
        default: False
author:
    - Frank Jung (frank.jung@marlo.com.au)
'''

EXAMPLES = '''
    - simple_module: name='earth'
'''

RETURN = '''
ansible_facts:
    name: string
changed: C(True) or C(False)
meta: string
'''


def main():
    """ Simple Ansible module to print a greeting. """
    module = AnsibleModule(argument_spec=dict(name=dict(required=True)),
                           supports_check_mode=True)
    response = {"hello": module.params.get('name')}
    module.exit_json(changed=False,
                     meta=response,
                     ansible_facts=dict(name=module.params.get('name')))


#
# MAIN
#
if __name__ == '__main__':
    main()
