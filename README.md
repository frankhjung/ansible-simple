# ansible-simple

A simple Ansible example project.

working copy
------------

Get localhost information:

    ansible all -m setup
    
Here is output from running `./apply.sh`:

    $ ./apply.sh 

        PLAY [run all playbooks] *******************************************************

    TASK [setup] *******************************************************************
    ok: [localhost]

    TASK [getinfo : get localhost info] ********************************************
    ok: [localhost]

    TASK [getinfo : debug] *********************************************************
    ok: [localhost] => {
        "result.ansible_facts.ansible_system_vendor": "LENOVO"
    }

    PLAY RECAP *********************************************************************
    localhost                  : ok=3    changed=0    unreachable=0    failed=0   



initial commit
--------------

Gets error:

    $ ansible-playbook all site.yml 
    ERROR! the playbook: all could not be found

