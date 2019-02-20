FROM python:3.6
LABEL maintainer="wwtg99 <wwtg99@126.com>"

ENV DJANGO_VERSION="2.0" APP_NAME="server"
RUN apt-get update -y && apt-get install -y nginx supervisor && \
    pip install gunicorn django==${DJANGO_VERSION} && \
    mkdir -p /opt/logs/nginx /opt/logs/gunicorn /server
COPY container_files /
WORKDIR /server
ENTRYPOINT sh /run.sh
VOLUME ["/server", "/opt/logs"]
EXPOSE 80
