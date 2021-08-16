FROM alpine:latest

MAINTAINER MJA <mja.ise.1981@gmail.com>

RUN apt update
RUN apt -yq install rsync openssh-client

# RUN apk update \
# 	&& apk upgrade \
# 	&& apk add --no-cache rsync openssh-client \
# 	&& rm -rf /var/cache/apk/*

# Labels
# LABEL "com.github.actions.name"="Laravel Rsync Deploy"
# LABEL "com.github.actions.description"="Deploy Laravel developed project with Rsync"
# LABEL "com.github.actions.color"="blue"
# LABEL "com.github.actions.icon"="upload"

# LABEL "repository"="https://github.com/SHSharkar/Laravel-Rsync-Deploy"
# LABEL "homepage"="https://github.com/SHSharkar/Laravel-Rsync-Deploy"
# LABEL "maintainer"="Md. Sazzad Hossain Sharkar <sh@sharkar.net>"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]


# FROM alpine:latest

# MAINTAINER MJA <mja.ise.1981@gmail.com>

# RUN apk update \
# 	&& apk upgrade \
# 	&& apk add --no-cache rsync openssh-client \
# 	&& rm -rf /var/cache/apk/*

# COPY entrypoint.sh /script/entrypoint.sh

# WORKDIR /workspace

# ENTRYPOINT ["/bin/sh", "/script/entrypoint.sh"]

# CMD ["deploy"]
