#!/bin/bash

set -o errexit
set -o pipefail

for arch in $ARCHS; do
	case "$arch" in
		'amd64')
			base_image="resin/amd64-alpine:3.3"
		;;
		'i386')
			base_image="resin/i386-alpine:3.3"
		;;
		'armhf')
			base_image="resin/armhf-alpine:3.3"
		;;
	esac
	dir=glibc-bin-$arch-alpine-$version

	sed -e s~#{BASE_IMAGE}~$base_image~g Dockerfile.tpl > Dockerfile

	docker build -t nghiant2710/alpine-pkg-builder:$arch .
done
