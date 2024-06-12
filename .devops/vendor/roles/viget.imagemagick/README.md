viget.imagemagick
=================

Installs and secures ImageMagick.

Installation
------------

Add the following to your `requirements.yml` file:

```yaml
- src:     git@github.com:vigetlabs/ansible-role-imagemagick.git
  scm:     git
  name:    viget.imagemagick
  version: 1.3.0
```

To install:

```
ansible-galaxy install -r requirements.yml
```

To upgrade to a newer version of this role, update your `requirements.yml` with the correct `version` number, then run:

```
ansible-galaxy install -r requirements.yml --force viget.imagemagick
```


Role Variables
--------------

```yaml
imagemagick_disk:
```

Sets disk usage limit.

```yaml
imagemagick_memory:
```

Sets memory usage limit.

```yaml
imagemagick_policies: []
```

Allows the `policy.xml` to be configured with custom values. Accepts a list of dictionaries with the keys: `domain`, `rights`, `pattern`.


Author
------

Chris Jones
Viget Labs
https://www.viget.com
