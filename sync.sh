#!/bin/bash
ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
FILES_DIR=$ROOT_DIR/files
BACKUP_DIR=$ROOT_DIR/backup

sync() {
  case $DIRECTION in
    "PULL")
      mkdir -p $LOCAL_DIR
      rsync -arzv --files-from=$FILES $REMOTE_DIR $LOCAL_DIR
      ;;
    "PUSH")
      rsync -arzv --files-from=$FILES $LOCAL_DIR $REMOTE_DIR
      ;;
  esac
}

home() {
  echo "Syncing home..."
  echo ""
  FILES=$FILES_DIR/home.txt
  LOCAL_DIR=$BACKUP_DIR/home
  REMOTE_DIR=/home/$USER
  sync
  echo ""
}

fail2ban() {
  echo "Syncing fail2ban..."
  echo ""
  FILES=$FILES_DIR/fail2ban.txt
  LOCAL_DIR=$BACKUP_DIR/fail2ban
  REMOTE_DIR=/etc/fail2ban
  sync
  echo ""
}

htpasswd() {
  echo "Syncing htpasswd..."
  echo ""
  FILES=$FILES_DIR/htpasswd.txt
  LOCAL_DIR=$BACKUP_DIR/htpasswd
  REMOTE_DIR=/etc/htpasswd
  sync
  echo ""
}

nginx() {
  echo "Syncing nginx..."
  echo ""
  FILES=$FILES_DIR/nginx.txt
  LOCAL_DIR=$BACKUP_DIR/nginx
  REMOTE_DIR=/etc/nginx
  sync
  echo ""
}

servarr() {
  echo "Syncing servarr..."
  echo ""
  FILES=$FILES_DIR/servarr.txt
  LOCAL_DIR=$BACKUP_DIR/servarr
  REMOTE_DIR=/opt/servarr
  if [[ $DIRECTION == "PUSH" ]]; then
    mkdir -p $REMOTE_DIR/data/{downloads,media}/{movies,tv}
    chown -R $USER:$USER $REMOTE_DIR
  fi
  sync
  echo ""
}

all() {
  home
  fail2ban
  htpasswd
  nginx
  servarr
}

for tool in rsync; do
  if ! command -v $tool &> /dev/null; then
    sudo apt-get install -y $tool > /dev/null
  fi
done

case $1 in
  pull) DIRECTION="PULL" ;;
  push) DIRECTION="PUSH" ;;
esac

case $2 in
  home) home ;;
  fail2ban) fail2ban ;;
  htpasswd) htpasswd ;;
  nginx) nginx ;;
  servarr) servarr ;;
  all) all ;;
esac
