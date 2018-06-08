FROM rocker/tidyverse:3.5.0

RUN apt-get update

RUN set -x && \
  install2.r --error \
    conflicted \
    DT \
    spelling  && \
  installGithub.r \
    'r-lib/devtools'

