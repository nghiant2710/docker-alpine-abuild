#!/bin/bash

main() {
	mkdir -p "$REPODEST" "$REPOSOURCE" /home/builder/.abuild
	if [ ! -z "$RSA_PRIVATE_KEY" ]; then 
		echo -e "$RSA_PRIVATE_KEY" > "/home/builder/.abuild/$RSA_PRIVATE_KEY_NAME"
		export PACKAGER_PRIVKEY="/home/builder/.abuild/$RSA_PRIVATE_KEY_NAME"
	fi
	cp $SOURCE/* $REPOSOURCE/
	cd $REPOSOURCE
	mkdir -p /var/cache/distfiles
	curl -SL $PACKAGE -o glibc-bin.tar.gz
	cp glibc-bin.tar.gz /var/cache/distfiles/
	abuild "$@"
	cp -f $REPODEST/* $OUTPUT/
}

main "$@"
