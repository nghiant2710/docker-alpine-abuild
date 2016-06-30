FROM #{BASE_IMAGE}
RUN apk --no-cache add alpine-sdk coreutils curl \
	&& adduser -G abuild -g "Alpine Package Builder" -s /bin/ash -D builder \
	&& echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY build-scripts/* /usr/bin/
USER builder
WORKDIR /home/builder
ENV RSA_PRIVATE_KEY_NAME ssh.rsa
ENV PACKAGER_PRIVKEY /home/builder/${RSA_PRIVATE_KEY_NAME}
ENV REPODEST /home/builder/package
ENV REPOSOURCE /home/builder/source
ENV SOURCE /source
ENV OUTPUT /output
