#!/bin/bash

# This is a wrapper around ansible-playbook just so you don't need to type all
# the parameters. There is also a project lint option.

# set -o xtrace

if [[ "$1" == "lint" ]]; then
  # lint all playbooks excluding git warning
  ansible-lint site.yaml
else
  # apply playbook to install and configure dokuwiki
  # shellcheck disable=SC2048 # need white space in var
  # shellcheck disable=SC2086 # allow word splitting
  ansible-playbook -i inventory.yaml -c local -e target="$(uname -n)" site.yaml $*
  rm -f site.retry scrapbook.retry
fi

# EOF
