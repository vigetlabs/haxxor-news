viget.postgresql
================

Installs PostgreSQL and manages users and databases.

Installation
------------

Add the following to your `requirements.yml` file:

```yaml
- src:     git@github.com:vigetlabs/ansible-role-postgresql.git
  scm:     git
  name:    viget.postgresql
  version: 2.5.0
```

To install:

```
ansible-galaxy install -r requirements.yml
```

To upgrade to a newer version of this role, update your `requirements.yml` with the correct `version` number, then run:

```
ansible-galaxy install -r requirements.yml --force viget.postgresql
```

Role Variables
--------------

Default values are listed.

```yaml
postgresql_role: # client or server
```

This must be one of `client` or `server`.

```yaml
postgresql_version: 12
```

The version of PostgreSQL to install. Valid values are:

- `9.5`
- `9.6`
- `10`
- `11`
- `12`
- `13`
- `14`

```yaml
postgresql_server_user: postgres
```

```yaml
postgresql_users: []
```

Takes a list of dictionaries, which must have `name` and `password` keys for username and password, respectively.

```yaml
postgresql_databases: []
```

Takes a list of dictionaries, each of which must have `name` and `owner` keys, where `owner` is a PostgreSQL user.

Optionally accepts an `extensions` key with an array of extensions to be enabled for the database.

Author
------

Chris Jones
Viget Labs
https://www.viget.com
