#Last package update 20 November 2023
FROM lscr.io/linuxserver/transmission:latest
LABEL Maintainer="bizalu"

# Prepare environnement
RUN apk -U upgrade --no-cache

# Install custom post script
COPY custom-script/ /custom-cont-init.d
RUN chmod u+x /custom-cont-init.d/*
