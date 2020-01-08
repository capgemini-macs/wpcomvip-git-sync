FROM alpine

LABEL "com.github.actions.name"="WP VIP Git Sync Action"
LABEL "com.github.actions.description"="Sync defined branches between two repositories to align with a specific workflow."
LABEL "com.github.actions.icon"="git-branch"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/capgemini-macs/wpcomvip-git-sync"
LABEL "homepage"="https://github.com/capgemini-macs/wpcomvip-git-sync"
LABEL "maintainer"="Capgemini MACS <macs.pl@capgemini.com.com>"

RUN apk add --no-cache git openssh-client && \
  echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]
