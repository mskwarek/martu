# Ansible playbook with my default env config
Here you can find some scripts that makes my working environments consistent.

## Run

For now supported OS is Debian 10. To provision your machinem run:

`ansible-playbook -u <user> -i hosts -K playbook.yml --ask-vault-pass`

You will be asked to type respectively *root password* and *vault password*
where passphrase to decrypt `hosts.yml` file is stored.

## Project structure

```console
.
├── playbook.yml
└── roles
    ├── dev
    │   └── tasks
    │       └── main.yml
    ├── spacemacs
    │   └── tasks
    │       └── main.yml
    ├── ssh
    │   ├── defaults
    │   │   └── hosts.yml
    │   ├── hosts.yml
    │   ├── tasks
    │   │   └── main.yml
    │   └── templates
    │       └── config.j2
    ├── where_is_my_env
    │   └── tasks
    │       └── main.yml
    └── yubikey
        └── tasks
            └── main.yml
```

There are several roles which I consider useful: 

* dev -- contains CLI tools that I use to develop stuff, compilers, docker
         engine and some python3 packages
* spacemacs -- reponsible for installing (spac)emacs
* ssh -- set up all of my SSH connections to remote servers which I use on daily
         basis
* where_is_my_env -- set up my *window*/graphical interface
* yubikey -- installs packages for yubikey support and makes possible to use
             yubikey in SSH authentication

### SSH connection

The `hosts.yml` file is encrypted using *ansible-vault*. To present file
stucture, the `roles/ssh/defaults/hosts.yml` file was added.

To decrypt `hosts.yml` file run: `ansible-vault decrypt roles/ssh/hosts.yml`
To encrypt `hosts.yml` file run: `ansible-vault encrypt roles/ssh/hosts.yml`
