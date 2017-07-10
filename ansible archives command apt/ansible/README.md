# ansible-role-supla

Ansible role for project Supla https://github.com/SUPLA

Allow to keep current version of supla-server, supla-cloud, supla-dev. 

## Requirements

Ansible 2.2, Debian 8 or Ubuntu 16.04

## Variables

Available variables are listed below.

#### Necessary:
```
mysql_root_pass: secrespassword
supla_database_password: secretpassword
supla_secret: secrethash
```

#### Other:
```
supla_ssl_enabled: True
supla_generate_cert: True
supla_openssl_version: openssl-1.0.1t
supla_composer_path: /usr/local/bin/composer
supla_path: /home/supla
```
#### To keep current version:
```
install_supla_server: True
install_supla_cloud: True
install_supla_dev: False
```

#### For configure symfony2 app
```
supla_mailer_transport: null
supla_mailer_host: null
supla_mailer_user: null
supla_mailer_password: null
supla_mailer_port: null
supla_mailer_encryption: null
supla_mailer_from: null
supla_admin_email: null
supla_server: supla
supla_server_list: null
supla_locale: en
supla_ewz_recaptcha_public_key: null
supla_ewz_recaptcha_private_key: null
```

## Example Playbook
```
- hosts: all
  become: true
  vars:
    mysql_root_pass: secretpassword
    supla_database_password: secretpassword
    install_supla_server: True
    install_supla_cloud: True
    install_supla_dev: True
    supla_generate_cert: True
    supla_server: supla.example.com
  roles:
    - role: supla
```
