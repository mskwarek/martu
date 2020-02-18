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
├── .gitlab-ci.yml
├── hosts
├── playbook.yml
├── README.md
└── roles
    ├── config
    │   ├── default
    │   │   └── mails.yml
    │   ├── mails.yml
    │   ├── tasks
    │   │   └── main.yml
    │   └── templates
    │       └── settings.org.j2
    ├── dev
    │   └── tasks
    │       └── main.yml
    ├── hardening
    │   └── tasks
    │       └── main.yml
    ├── spacemacs
    │   ├── files
    │   │   └── .spacemacs
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
        ├── files
        │   ├── gpg-agent.conf
        │   └── yubikey
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

The `hosts.yml` and `mails.yml` files are encrypted using *ansible-vault*. To
present file stucture, the following files were added:
- `roles/ssh/defaults/hosts.yml`
- `roles/config/default/mails.yml`

To decrypt `<encrypted>.yml` file run: `ansible-vault decrypt <path>.yml`
To encrypt `<decrypted>.yml` file run: `ansible-vault encrypt <path>.yml`
