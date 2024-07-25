# Ubuntu Server Sync

Backup/restore application configurations

## Install

```sh
curl -s https://raw.githubusercontent.com/goransimic/ubuntu-server-sync/master/install.sh | bash
```

## Usage

### Backup

```sh
ubuntu-server-sync pull all|home|fail2ban|htpasswd|nginx|servarr
```

### Restore

```sh
ubuntu-server-sync push all|home|fail2ban|htpasswd|nginx|servarr
```
