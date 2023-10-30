FROM lscr.io/linuxserver/transmission:latest
LABEL Maintainer="bizalu"

# Install custom post script
COPY custom-script/ /custom-cont-init.d
RUN chmod u+x /custom-cont-init.d/*
