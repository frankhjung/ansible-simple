# ansible-simple

A simple Ansible example module.


## Introduction

This is an example of how to write a simple Ansible module used for
self-instruction.


## Setup

Clone the Ansible suite into the root of this projects folder:

    git clone git://github.com/ansible/ansible.git --recursive
    source ansible/hacking/env-setup


## To test

To test this using the Ansible module test suite, call:

    ansible/hacking/test-module -m library/simple_module.py -a "name=world"


## To Run

Get `localhost` information:

    ansible all -m setup
    
To run module call:

    ansible-playbook site.yaml
