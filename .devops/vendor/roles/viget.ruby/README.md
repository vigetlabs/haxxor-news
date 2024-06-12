viget.ruby
==========

Installs Ruby and Bundler.

Installation
------------

Add the following to your `requirements.yml` file:

```yaml
- src:     git@github.com:vigetlabs/ansible-role-ruby.git
  scm:     git
  name:    viget.ruby
  version: 2.0.0
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
ruby_build_version: v20221206
```

```yaml
ruby_build_source: https://github.com/rbenv/ruby-build.git
```

```yaml
ruby_version:
```
The version of Ruby to be installed. Must be specified.

```yaml
ruby_bundler_version:
```
The version of Ruby Bundler to be installed. Must be specified.

Author
------

Viget Labs
https://www.viget.com
