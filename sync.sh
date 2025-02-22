#!/bin/bash

ROOT_DIR=$HOME/.local/share/ubuntu-server-sync
FILES_DIR=$ROOT_DIR/files
BACKUP_DIR=$ROOT_DIR/backup

sync() {
  case $DIRECTION in
    "PULL")
      mkdir -p $LOCAL_DIR
      rsync -aHAXxv --numeric-ids --info=progress2 --bwlimit=20000 --files-from=$FILES $REMOTE_DIR $LOCAL_DIR
      ;;
    "PUSH")
      rsync -aHAXxv --numeric-ids --info=progress2 --bwlimit=20000 --files-from=$FILES $LOCAL_DIR $REMOTE_DIR
      ;;
  esac
}

sync_home() {
  echo "Sync home..."
  FILES=$FILES_DIR/home.txt
  LOCAL_DIR=$BACKUP_DIR/home
  REMOTE_DIR=/home/$USER
  sync
}

sync_fail2ban() {
  echo "Sync fail2ban..."
  FILES=$FILES_DIR/fail2ban.txt
  LOCAL_DIR=$BACKUP_DIR/fail2ban
  REMOTE_DIR=/etc/fail2ban
  sync
}

sync_htpasswd() {
  echo "Sync htpasswd..."
  FILES=$FILES_DIR/htpasswd.txt
  LOCAL_DIR=$BACKUP_DIR/htpasswd
  REMOTE_DIR=/etc/htpasswd
  sync
}

sync_nginx() {
  echo "Sync nginx..."
  FILES=$FILES_DIR/nginx.txt
  LOCAL_DIR=$BACKUP_DIR/nginx
  REMOTE_DIR=/etc/nginx
  sync
}

sync_servarr() {
  echo "Sync servarr..."
  FILES=$FILES_DIR/servarr.txt
  LOCAL_DIR=$BACKUP_DIR/servarr
  REMOTE_DIR=/opt/servarr
  if [[ $DIRECTION == "PUSH" ]]; then
    mkdir -p $REMOTE_DIR/data/{downloads,media}/{movies,tv}
    chown -R $USER:$USER $REMOTE_DIR
  fi
  sync
}

sync_all() {
  sync_home
  sync_fail2ban
  sync_htpasswd
  sync_nginx
  sync_servarr
}

if ! command -v rsync &> /dev/null; then
  sudo apt-get install -y rsync > /dev/null
fi

case $1 in
  "pull") DIRECTION="PULL" ;;
  "push") DIRECTION="PUSH" ;;
esac

case $2 in
  "all") sync_all ;;
  "home") sync_home ;;
  "fail2ban") sync_fail2ban ;;
  "htpasswd") sync_htpasswd ;;
  "nginx") sync_nginx ;;
  "servarr") sync_servarr ;;
esac
