viget.nginx
===========

This role installs and configures nginx.

Configuration Templates
-----------------------

This role installs templates into the local ansible repository:

- `nginx-local.conf.j2`: this template is installed as `{{ nginx_confd_path }}/nginx-local.conf`. This file is the last `include` statement in `nginx.conf`, immediately before the site-specific configurations are included. Use this file to customize `http`-level configuration.
- `sites/<file>.conf.j2`: this template is installed as `{{ nginx_confd_path }}/sites-available/<file>.conf`. Each site gets its own template.

These templates allow for customization of `nginx.conf` and each site's configuration.

Installation
------------

Add the following to your `requirements.yml` file:

```yaml
- src:     git@github.com:vigetlabs/ansible-role-nginx.git
  scm:     git
  name:    viget.nginx
  version: 5.5.3
```

To install:

```
ansible-galaxy install -r requirements.yml
```

To upgrade to a newer version of this role, update your `requirements.yml` with the correct `version` number, then run:

```
ansible-galaxy install -r requirements.yml --force viget.nginx
```

Role Variables
--------------

Default values are listed.

```yaml
nginx_passenger: false
```

Set to `true` to install Phusion Passenger instead of stock nginx.

```yaml
nginx_passenger_repository: "{{ ansible_distribution_release }}"
```

Set the apt repo's OS release.

```yaml
nginx_web_root: /var/www
```

The top-most web root. All sites will be created inside this directory.

```yaml
nginx_web_root_owner: deploy
```

```yaml
nginx_web_root_group: www-data
```

```yaml
nginx_web_root_mode: "2775"
```

This default sets the `setgid` permission on the web root directory. This causes any files created inside this directory to inherit the group owner of the root.

This is it allows for a deploy user to be a member of the `nginx_web_root_group` group and write files into the web root.

```yaml
nginx_sites: []
```

A list of sites to configure. See the [Site Configuration](#site-configuration) section below.

Include the full filename.

```yaml
nginx_config_path: /etc/nginx
```

```yaml
nginx_confd_path: "{{ nginx_config_path }}/conf.d"
```

```yaml
nginx_dhparam_path:   "{{ nginx_config_path }}/dhparam.pem"
```

```yaml
nginx_extra_confd_files: []
```

Optional list of conf.d files to install. Each list entry is a dictionary with the following keys:

* `src`: local path to the template. This path is relative to `{{ playbook_dir }}/templates/nginx/conf.d`.
* `dest`: remote path to the installed file. This path is relative to `{{ nginx_confd_path }}/conf.d`.

For example, suppose you want to install a file to `{{ nginx_config_path }}/conf.d/server/coolfile.conf`. You'd put the template in `{{ playbook_dir }}/templates/nginx/conf.d/server/coolfile.conf.j2` and your vars would look like this:

```yaml
nginx_extra_confd_files:
  - src:  server/coolfile.conf.j2
    dest: server/coolfile.conf
```

```yaml
nginx_hsts: true
```

Set to `false` to disable HSTS.

```yaml
nginx_hsts_include_subdomains: false
```

Determines whether the HSTS header will apply to all subdomains. Set to `true` to enable.

```yaml
nginx_status_page: true
```

Starts a status page accessible at `http://localhost/__status__` for collecting stats. Set to `false` to disable this page.

```yaml
nginx_rate_limit: true
```

Set to `false` to disable basic rate limiting.

```yaml
nginx_rate_limit_key: binary_remote_addr
```

```yaml
nginx_php_fpm_socket: "/var/run/php/php{{ nginx_php_version }}-fpm-www.sock"
```

```yaml
nginx_php_version: "{{ php_version | default('7.3') }}"
```

```yaml
nginx_disabled_modules:
  - lua
  - perl
```

List of modules to disable by default. Perl and Lua are disabled because we don't use them and they increase the surface area for attacks and vulnerabilities.

Site Configuration
------------------

### Definitions

- **Application Path**: this is the path to the application root. This is not the document root—it's the path to the root of the application, where code is checked out, previous releases archived, shared files stored, etc.

  This path is automatically defined to be `{{ nginx_web_root }}/{{ site.name }}/{{ site.environment }}`, and will be created if it does not exist.
- **Document Root**: this is the path to the site's document root, _relative to the application path_. This is where nginx will serve files from.

  The full document root is always defined to be `{{ nginx_web_root }}/{{ site.name }}/{{ site.environment }}/{{ site.root }}`.

### Variables

The `nginx_sites` variable accepts a list of site configuration dictionaries. Variables are defined below, with defaults listed.

```yaml
name:
```

A short name for the site. This will be used to name various settings: config file, log files, web root directory, etc.

```yaml
domain:
```

The primary, canonical domain name.

```yaml
aliases: []
```

Any alternate domains for this site. These domains will automatically redirect to the specified canonical `domain`.


```yaml
file: "{{ site.domain }}.conf"
```

The filename of the generated config file, e.g. `cooldev.conf`. Defaults to the specified `domain` with `.conf` appended.

```yaml
template: "{{ file }}.j2"

The local template used to generate the `file`. Defaults to the site's `file` setting with `.j2` appended.

```yaml
type:
```

Specifies what kind of site is being configured. Results in a local site template specifically configured to host a site of this type.

Possible values:

  - `blank`
  - `craft`
  - `healthcheck`
  - `node`
  - `php`
  - `rails`
  - `static`

```yaml
environment:
```

The application's environment: 'staging', 'production', etc.

```yaml
root:
```

The path to the document root, specified relative to the application's path. (See [Definitions](#definitions) for details on what this means.)

```yaml
robots: yes
```

Determines whether robots are allowed to index the site. Set to `no` to disallow robots via the `X-Robots-Tag` header.

```yaml
ssl:
```

This role configures nginx to use SSL—there's no option to disable it. Use this variable to set the type of SSL the site will use.

This role doesn't create or manage the certificates. This variable only controls the path to the certificates files that have been created elsewhere.

The certificate path looks like this: `/etc/ssl/<site.domain>/<site.ssl>`.

For example, if `domain` is set to `cooldev.com` and `ssl` is set to `certbot`, the path will be `/etc/ssl/cooldev.com/certbot`.

Possible values:

- `certbot` (uses Let's Encrypt)
- `manual` (certificate files manually uploaded elsewhere)
- `selfsigned`

```yaml
force: no
```

By default, this role does not change the local site template once it's created. Set to `yes` to have this role manage the local site template and overwrite any customizations.

```yaml
auth:
```

Set to a dictionary to enable Basic Auth.

Dictionary values:

```yaml
user:     # required
password: # required
realm:    # optional, defaults to "Restricted"
```

Author
------

Viget Labs
https://www.viget.com
