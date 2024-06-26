---
# DC1 variables
fabric_name: dc1_fabric

# Credentials for CVP and EOS Switches
ansible_user: {{cvp_username}}
# Update password with lab credentials
ansible_password: {{cvp_password}}
ansible_network_os: arista.eos.eos
# Configure privilege escalation
ansible_become: true
ansible_become_method: enable
# HTTPAPI configuration
ansible_connection: httpapi
ansible_httpapi_port: 443
ansible_httpapi_use_ssl: true
ansible_httpapi_validate_certs: false
ansible_python_interpreter: $(which python3)