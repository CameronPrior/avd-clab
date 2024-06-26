---
- name: Deploying DC1 Changes via CVP
  hosts: {{cvp_ip}}
  connection: local
  gather_facts: false
  tasks:
    - name: run CVP provisioning
      import_role:
          name: arista.avd.eos_config_deploy_cvp
      vars:
        container_root: 'dc1_fabric'
        state: present
        execute_tasks: true