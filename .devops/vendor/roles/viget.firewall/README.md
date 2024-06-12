Firewall
=========

A simple wrapper around Ansible's UFW module.

Installation
------------

Add the following to your `requirements.yml` file:

```yaml
- src:     git@github.com:vigetlabs/ansible-role-firewall.git
  scm:     git
  name:    viget.firewall
  version: 1.2.0
```

To install:

```
ansible-galaxy install -r requirements.yml
```

To upgrade to a newer version of this role, update your `requirements.yml` with the correct `version` number, then run:

```
ansible-galaxy install -r requirements.yml --force viget.firewall
```

Role Variables
--------------

Default values are listed.

```yaml
firewall_ssh_port: 22
```

Sets the SSH port. The SSH firewall rule must be configured before the deny all rule, so we specify it explicitly here.

```yaml
firewall_rules: []
```

An array of rules. Each rule is a dictionary and can contain any of the following options. Defaults are shown. Note that `port` is required.

```yaml
  - rule:      allow
    direction: in
    interface: <omitted>
    proto:     tcp
    to:        <omitted>
    from:      <omitted>
    port:      <required>
```

Author
------

Viget Labs
https://www.viget.com
