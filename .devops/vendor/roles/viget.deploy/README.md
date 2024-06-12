viget.deploy
============

Creates a deploy user and adds authorized keys for SSH access.

This role is designed to create a deploy user who belongs to the `www-data` group and can read & write the deployed application's files.

Installation
------------

Add the following to your `requirements.yml` file:

```yaml
- src:     git@github.com:vigetlabs/ansible-role-deploy-user.git
  scm:     git
  name:    viget.deploy
  version: 1.2.1
```

To install:

```
ansible-galaxy install -r requirements.yml
```

To upgrade to a newer version of this role, update your `requirements.yml` with the correct `version` number, then run:

```
ansible-galaxy install -r requirements.yml --force viget.deploy
```

Role Variables
--------------

Default values are listed.

```yaml
deploy_user_create_user: yes
```

Set to `no` to skip account creation (useful if the account already exists).


```yaml
deploy_user: deploy
```


```yaml
deploy_user_home: /home/deploy
```


```yaml
deploy_user_groups:
  - www-data
```


```yaml
deploy_user_keys_dir: "{{ inventory_dir }}"
```

Directory to be used as the base path for key files specified in `deploy_user_authorized_keys`.


```yaml
deploy_user_authorized_keys: []
```

Array of key files to be added to the deploy user's `~/.ssh/authorized_keys` file. Key files are paths relative to `deploy_user_keys_dir`.


```yaml
deploy_user_generate_ssh_key: no
```

Set to `yes` to generate an SSH key pair for the deploy user.


```yaml
deploy_user_fetch_ssh_key: no
```

If set to `yes`, the generated SSH key will be downloaded to the local machine.


```yaml
deploy_user_fetch_ssh_key_path: "{{ inventory_dir }}/keys/{{ inventory_hostname }}/deploy.pub"
```

If `deploy_user_fetch_ssh_key` is `yes`, this option specifies the local path to which the generated key will be downloaded.


```yaml
deploy_user_install_ssh_key: no
```
Set to `yes` to provide an SSH key pair that will be installed for this user. See `deploy_user_ssh_public_key` and `deploy_user_ssh_private_key`.


```yaml
deploy_user_ssh_public_key:
```

The public key contents to be installed when `deploy_user_install_ssh_key` is set.


```yaml
deploy_user_ssh_private_key:
```

The private key contents to be installed when `deploy_user_install_ssh_key` is set.


```yaml
deploy_user_cache_github_host_key: yes
```

Caches GitHub's host key, so deploys can successfully connect to GitHub.


Author
------

Chris Jones
Viget Labs
https://www.viget.com
