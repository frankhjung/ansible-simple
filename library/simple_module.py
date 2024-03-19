#!/usr/bin/python
# coding: utf-8
"""
A simple Ansible module based on Hello World example from
[Custom Ansible
Module](http://blog.toast38coza.me/custom-ansible-module-hello-world/).
"""

from ansible.module_utils.basic import AnsibleModule

ANSIBLE_METADATA = {
    "metadata_version": "1.0",
    "status": ["preview"],
    "supported_by": "community",
}

DOCUMENTATION = """
---
module: simple_module
version_added: 2.2
short_description: Print hello world
description:
    - A simple Ansible module that prints a "hello world" message.
options:
    - name:
        description:
            - name to print
        default: False
author:
    - Frank Jung (frank.jung@marlo.com.au)
"""

EXAMPLES = """
    - simple_module: name='earth'
"""

RETURN = """
ansible_facts:
    name: string
changed: C(True) or C(False)
meta: string
"""


def main():
    """Simple Ansible module to print a greeting."""
    module_args = {
        "name": {"required": True, "type": "str"},
    }
    # seed result with default values
    result = {"changed": False, "message": ""}
    module = AnsibleModule(argument_spec=module_args, supports_check_mode=True)
    # if in check mode then return current state without modification
    if module.check_mode:
        module.exit_json(**result)
    # build response
    if module.params.get("name") == "test":
        result = {"changed": False, "message": "Test"}
    else:
        result = {
            "changed": True,
            "message": "Hello " + module.params.get("name"),
        }
    module.exit_json(**result)


#
# MAIN
#
if __name__ == "__main__":
    main()
