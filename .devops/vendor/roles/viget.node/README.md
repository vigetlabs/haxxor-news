viget.node
==========

Installs Node.

Installation
------------

Add the following to your `requirements.yml` file:

```yaml
- src:     git@github.com:vigetlabs/ansible-role-node.git
  scm:     git
  name:    viget.node
  version: 1.8.0
```

To install:

```
ansible-galaxy install -r requirements.yml
```

To upgrade to a newer version of this role, update your `requirements.yml` with the correct `version` number, then run:

```
ansible-galaxy install -r requirements.yml --force
```

Role Variables
--------------

Default values are listed.

```yaml
node_version: 12.16.1
```

```yaml
node_build_version: v4.7.2
```

```yaml
node_build_source: https://github.com/nodenv/node-build.git
```

```yaml
node_install_yarn: true
```

```yaml
node_yarn_version: 1.21.1
```

Author
------

Chris Jones
Viget Labs
https://www.viget.com
