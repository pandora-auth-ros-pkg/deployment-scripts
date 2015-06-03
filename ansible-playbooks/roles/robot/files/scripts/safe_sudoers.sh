#!/bin/sh

if [ -z "$1" ]; then
  export EDITOR=$0 && sudo -E visudo
else
  echo "\npandora ALL=(ALL) NOPASSWD: /sbin/shutdown,/sbin/reboot,/bin/mount,/bin/umount" >> $1
fi
