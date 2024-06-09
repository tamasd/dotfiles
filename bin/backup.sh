#!/bin/bash

set -xe

cd $HOME

FILENAME=backup-$(hostname).tar.gz.gpg

tar --exclude=target --exclude=vendor --exclude=node_modules --exclude=zig-cache --exclude=.zig-cache --exclude=zig-out -cf - Projects | \
	gzip -9 | \
	gpg --encrypt -r AECD4A22A8C7F19583C0B03ECCAD8960035C19E0 > /tmp/$FILENAME

mv /tmp/$FILENAME $HOME/Sync/$FILENAME

