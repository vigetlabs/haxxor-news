# CLIENT NAME Ansible Playbooks

1. [Dependencies](#dependencies)
1. [Setup](#setup)
    1. [Terraform setup (optional)](#terraform-setup-optional)
1. [Directory structure](#directory-structure)
1. [Common tasks](#common-tasks)
    1. [Bootstrapping a new server](#bootstrapping-a-new-server)
    1. [Granting deploy access](#granting-deploy-access)
    1. [Revoking deploy access](#revoking-deploy-access)
    1. [Connecting to a server](#connecting-to-a-server)
    1. [Running commands as root](#running-commands-as-root)

## Dependencies

- [Ansible](https://www.ansible.com) >= 2.7
- [Terraform](https://www.terraform.io/) (optional)

This repo requires servers running Ubuntu 18.04. It will not work for other versions of Linux.

## Setup

1. Save the Ansible Vault password in a file named `.password` at the root of this repository
2. Save the Ansible private key in a file named `keys/system/ansible`
3. Set correct permissions on the private key file: `chmod 600 keys/system/ansible`

### Terraform setup (optional)

This repo contains Terraform code and state for resources on Digital Ocean. Terraform is not required for managing existing server configuration. However, if you wish to use Terraform to manage infrastructure, use the following steps to get set up.

1. Copy the example Terraform config:

    ```
    cp terraform/config.auto.tfvars{,.example}
    ```

2. Update `terraform/config.auto.tfvars` with the relevant info.

2. Initialize Terraform:

    ```
    cd terraform
    terraform init
    ```

## Directory Structure

This repo is a fairly standard Ansible project. Here are the directories and what they're used for:

- `group_vars`: YAML configs that apply to groups of servers.
- `host_vars`: YAML configs for each individual server.
- `keys`: System and user SSH keys.
- `roles`: Roles shared across servers.
- `servers`: Server-specific playbooks.
- `terraform`: Terraform config for managing Digital Ocean resources.
- `vendor`: Third-party Ansible roles are vendored here.

## Common Tasks

### Granting deploy access

Deploy access happens via a shared user, `deploy`. Granting deploy access simply requires adding the new user's public key to `deploy`'s list of authorized keys.

To do this:

1. Add the user's public key to the `keys/users` folder, in a file named with their first initial and last name. For example: `keys/users/bwayne.pub`

2. Edit the file at `group_vars/all.yml` and add the new key to the `deploy_user_authorized_keys` list:

    ```yaml
    deploy_user_authorized_keys:
      - keys/users/jgordon.pub
      - keys/users/hdent.pub
      - keys/users/bwayne.pub # <- path to new key
    ```

3. Run the Ansible playbook, scoping to the `deploy` tag:

    ```
    ansible-playbook servers/site/main.yml -t deploy
    ```

Note that, by default, deploy access is granted for all servers. To specify more granular deploy access, override `deploy_user_authorized_keys` in a specific server's `host_vars/<server>/all.yml` config file.

### Revoking deploy access

To revoke deploy access:

1. Delete the user's public key file from `keys/users`.

2. Edit the file at `group_vars/all.yml` and remove the key from the `deploy_user_authorized_keys` list:

    ```yaml
    deploy_user_authorized_keys:
      - keys/users/jgordon.pub
      - keys/users/hdent.pub
      - keys/users/bwayne.pub # <- remove this line
    ```

3. Run the Ansible playbook, scoping to the `deploy` tag:

    ```
    ansible-playbook servers/site/main.yml -t deploy
    ```

### Connecting to a server

The IP address for each server is set in the `ansible_host` variable in the server's `host_vars/<server>/all.yml` file.

To connect to a server:

1. Copy the IP address from the `host_vars/<server>/all.yml` file of the server you wish to connect to.

2. Use SSH and the Ansible private key to connect as the `ansible` user:

    ```
    ssh -i keys/system/ansible ansible@<IP address>
    ```

### Running commands as root

The `ansible` user is configured with password-less `sudo` privileges.

To run commands as root:

1. [Connect to the server](#connecting-to-a-server) as described in the previous section.

2. Run a single command as root:

    ```
    sudo su <command to run>
    ```

    Start a shell as root:

    ```
    sudo su
    ```

### Bootstrapping a new server

When you set up a new server, you'll first need to bootstrap it by updating software and creating the `ansible` user that Ansible will connect as over SSH. Assume we're creating a new host called `demo`--to do this:

1. Create a new directory at `host_vars/demo`.

2. Create a new config file at `host_vars/demo/all.yml` with the following content:

    ```yaml
    ---
    ansible_host: <new server IP>
    ansible_user: ansible
    ```

3. Append `demo` to the end of the `inventory` file.

3. Run the bootstrap playbook:

    ```
    ansible-playbook vendor/roles/viget.base/playbooks/bootstrap.yml -l demo
    ```

4. The above command connects as `root`. If you need to connect as a non-`root` user via password authentication:

    ```
    ansible-playbook vendor/roles/viget.base/playbooks/bootstrap.yml -l demo -e "ansible_user=<username>" -b -k -K
    ```

    If you need to connect as a non-`root` user via a private key (e.g. for AWS):
    ```
    ansible-playbook vendor/roles/viget.base/playbooks/bootstrap.yml -l demo -e "ansible_user=<username>" -b --private-key path/to/private/key
    ```
