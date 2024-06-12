viget.rails
===========

This role handles setting up a Rails app's directory structure and config files.

Installation
------------

Add the following to your `requirements.yml` file:

```yaml
- src:     git@github.com:vigetlabs/ansible-role-rails-app.git
  scm:     git
  name:    viget.rails
  version: 4.1.0
```

To install:

```
ansible-galaxy install -r requirements.yml
```

To upgrade to a newer version of this role, update your `requirements.yml` with the correct `version` number, then run:

```
ansible-galaxy install -r requirements.yml --force viget.rails
```

Global Variables
----------------

Default values are listed.

```yaml
rails_apps: []
```
List of apps and their configuration variables. See [App Variables](#app-variables).

```yaml
rails_app_owner: www-data
rails_app_group: www-data
rails_app_mode:  "2775"
```

Default user, group, and mode for app directories.


App Variables
-------------

```yaml
name:
```

Required. A name for this application. Will be used in the default filesystem path and in the logrotate config file name.

```yaml
environment:
```

Required. The Rails environment. Will be used in the default filesystem path and in the logrotate config file name.

Each app can have the following variables:

```yaml
path:
```

Optional. The full filesystem path to the application root. Note that this is the root of the deployed app's tree, _not_ the Rails root.

If not specified, the path defaults to `/var/www/{{ app.name }}/{{ app.environment }}`.

```yaml
owner: "{{ rails_app_owner }}"
group: "{{ rails_app_group }}"
mode:  "{{ rails_app_mode }}"
```

Optional directory permissions overrides. Defaults to the [global values](#global-variables).

```yaml
config_files: []
```

A list of config files to install. Must contain a `src` path (relative to the current playbook's local filesystem path) and a `dest` path (relative to the app's `path`, set above).

Each item in the array is exposed to the template using the `config` variable name, rather than the default `item`. This makes it a little nicer to do things like add secrets directly to this dictionary and reference them in the template:

```yaml
# vars file

rails_apps:
  - config_files:
      - src: path/to/template.j2
        dest: path/to/file
        secret_code_word: pineapple
```

```yaml
# template

production:
  secret_code_word: {{ config.secret_code_word }}
```


Templates
---------

Templates referenced in the `config_files` app variable can access all of an app's variables under the `app` dictionary.

For example, given this config:

```yaml
rails_apps:
  - path:          /var/www/cooldev/staging
    environment:   staging
    secret:        1991372ae83ee6e729be7e85656d88
    database_user: chris
    database_name: cooldevs
    config_files:
      - src:  templates/app/secrets.yml.j2
        dest: shared/config/secrets.yml
```

The template `secrets.yml.j2` might look like this:

```yaml
{{ app.environment }}:
  secret_key_base: {{ app.secret }}
  database:
    username: {{ app.database_user }}
    name:     {{ app.database_name }}
```

Author
------

Chris Jones  
Viget Labs  
https://www.viget.com
