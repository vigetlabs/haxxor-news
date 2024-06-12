viget.ssl
=========

This role manages certbot, selfsigned, and manually acquired SSL certificates.

Installation
------------

Add the following to your `requirements.yml` file:

```yaml
- src:     git@github.com:vigetlabs/ansible-role-ssl.git
  scm:     git
  name:    viget.ssl
  version: 1.2.2
```

To install:

```
ansible-galaxy install -r requirements.yml
```

To upgrade to a newer version of this role, update your `requirements.yml` with the correct `version` number, then run:

```
ansible-galaxy install -r requirements.yml --force viget.ssl
```

Role Variables
--------------

```yaml
ssl_certificates: []
```

List of SSL certificates to be installed on the server. Each entry has a `type` key that can be one of:

* [`certbot`](#certbot-certificates)
* [`selfsigned`](#certbot-certificates)
* [`manual`](#certbot-certificates)

```yaml
ssl_certbot_root: /etc/letsencrypt
```

Root directory for certbot configuration.

```yaml
ssl_root: /etc/ssl
```

Root directory for certificate storage.


```yaml
ssl_certbot_renewal_hook: nginx
```

The webserver which should be restarted after a successful renewal. Valid options are:

* `nginx`
* `apache`

```yaml
ssl_certbot_renewal_hook_nginx: systemctl reload nginx
```

The specific command executed by the renewal hook.

```yaml
ssl_install_certbot: true
```

Set to `false` to disable automatic certbot installation.

```yaml
ssl_install_legacy:  false
```

Install the legacy version of certbot. This option exists to accommodate Ubuntu 14.04 servers.


Certificates Variables
----------------------

### `certbot` Certificates

```yaml
type: certbot
```

Specifies the certificate will be managed by certbot.

```yaml
mode: standalone
```

Can be one of:

* `standalone` (default): certbot binds to port 80 and starts its own web server to verify the challenge
* `webroot`: certbot does not bind to any port, and instead verifies the challenge by writing into the webroot
* `route53`: certbot will verify the challenge via Route 53 DNS. This method enables creation of wildcard certs, but requires AWS credentials in `/root/.aws/credentials`. See the `credentials` option for information on providing these.
* `dnsimple`: certbot will verify the challenge via DNSimple. This method enables creation of wildcard certs, but requires DNSimple credentials in `/root/.dnsimple/credentials`. See the `credentials` option for information on providing these.

```yaml
domain:
```

The primary domain on the certificate.

```yaml
aliases: []
```

A list of secondary domains that will be included on the certificate.

```yaml
email:
```

Email address used by certbot to send expiration notifications.

```yaml
# route53
credentials:
  access_key_id:
  secret_access_key:

# dnsimple
credentials:
  api_token:
```

Optional credentials for the DNS challenge modes.

```yaml
staging: false
```

Set to `true` to have certbot query the staging API.


### `selfsigned` Certificates

```yaml
type: selfsigned
```

Specifies the certificate will be selfsigned by the server.

```yaml
domain:
```

The primary domain on the certificate.

```yaml
aliases: []
```

A list of secondary domains that will be included on the certificate.


### `manual` Certificates

```yaml
type: manual
```

Specifies the certificate, private key, and chain will be provided manually, via Ansible.

```yaml
domain:
```

The primary domain on the certificate.

```yaml
certificate:
```

The certificate.

```yaml
private_key:
```

The certificate's private key.

```yaml
public_key:
```

Optional. The certificate's public key.

```yaml
chain:
```

Optional. The certificate's trust chain. Should only include intermediate certificates, do not include root certificates or the `certificate` specified above.

```yaml
csr:
```

Optional. The CSR used to generate the certificate. This file isn't used by the server but can be provided for record keeping purposes.



Author
------

Chris Jones
Viget Labs
https://www.viget.com
