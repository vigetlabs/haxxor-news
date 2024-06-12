viget.base
==========

Performs base server configuration:

- Sets the default system locale
- Configures automatic security updates
- Installs fail2ban
- Configures SSH with sensible security settings
- Installs and configures NTP
- Configures swap storage
- Configures vim with sensible defaults

This role has been adapted from:

- [`geerlingguy.security`](https://github.com/geerlingguy/ansible-role-security)
- [`geerlingguy.ntp`](https://github.com/geerlingguy/ansible-role-ntp)
- [`kamaln7.swapfile`](https://github.com/kamaln7/ansible-swapfile)

Installation
------------

Add the following to your `requirements.yml` file:

```yaml
- src:     git@github.com:vigetlabs/ansible-role-base.git
  scm:     git
  name:    viget.base
  version: 3.7.3
```

To install:

```
ansible-galaxy install -r requirements.yml
```

To upgrade to a newer version of this role, update your `requirements.yml` with the correct `version` number, then run:

```
ansible-galaxy install -r requirements.yml --force viget.base
```

Bootstrapping a Server
----------------------

This role contains a playbook to bootstrap a server by creating an `ansible` system account with `sudo` privileges.

To run it:

```
ansible-playbook -e "ansible_user={system_user}" -l <server name> vendor/roles/viget.base/playbooks/bootstrap.yml
```

Role Variables
--------------

Default values are listed.

### SSH

```yaml
base_secure_ssh: yes
```

Set to `false` to disable SSH configuration.

```yaml
base_ssh_port: 22
```

```yaml
base_ssh_challenge_response_auth: "no"
base_ssh_gss_api_authentication:  "no"
base_ssh_password_authentication: "no"
base_ssh_permit_empty_password:   "no"
base_ssh_permit_root_login:       "no"
base_ssh_usedns:                  "no"
base_ssh_x11_forwarding:          "no"
```

These are the SSH settings configured by this role.

**Note**: the quotes around `"no"` are required. Don't remove them!

```yaml
base_ssh_options: []
```

Additional SSH options to be configured. Specify as a list of dictionaries with the keys `regexp` (the line to match) and `line` (the replacement text):

```yaml
base_ssh_options:
  - regexp: ^AllowAgentForwarding
    line:   AllowAgentForwarding yes
```

```yaml
base_ssh_allow_users_enabled: false
```

Set to `true` to restrict the allow SSH users to those specified in `base_ssh_allow_users`. Note that the `ansible` user is always granted access so it's impossible to accidentally revoke access.

```yaml
base_ssh_allow_users: []
```

A whitelist of users to grant SSH access.


### unattended-upgrades

```yaml
base_autoupdate_enabled: yes
```

```yaml
base_autoupdate_blacklist: []
```

Packages to add to the `Unattended-Upgrade::Package-Blacklist` list. Packages in this list will not be automatically upgraded.

```yaml
base_autoupdate_allowed_origins: []
```

Origins to add to the `Unattended-Upgrade::Allowed-Origins` list. For example, this is useful for Rackspace servers, where a custom origin is typically present for upgrading Rackspace's cloud monitoring packages.

```yaml
base_autoupdate_remove_unused: true
```

This option will run `apt-get autoremove` when packages are installed. Running it will prevent old Linux kernel versions from building up over time and using up all of the disk space.

### fail2ban

```yaml
base_fail2ban_enabled: yes
```

### locale

```yaml
base_locale: en_US.UTF-8
```

### NTP

```yaml
base_timezone: America/New_York
```

```ymal
base_timedatectl_enabled: yes
```

By default, uses Ubuntu's built-in `timedatectl` time synchronization mechanism.

```yaml
base_ntp_enabled: no
```

Legacy time synchronization using NTP.

### swap

```yaml
base_swapfile_enabled: yes
```

```yaml
base_swapfile_location: /swapfile
```

```yaml
base_swapfile_size: 1024MB
```

```yaml
base_swapfile_swappiness: 10
```

```yaml
base_swapfile_vfs_cache_pressure: 50
```

```yaml
base_swapfile_use_dd: False
```

Author
------

Chris Jones
Viget Labs
https://www.viget.com
