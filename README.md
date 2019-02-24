Django Docker
=============

# Description
Docker image for django and nginx.

# Usage

## Basic Usage

```
docker run -d -p 80:80 wwtg99/docker-django
```

Add your django project.
```
docker run -d -p 80:80 -e "APP_NAME=your_app" -v django_project:/server wwtg99/docker-django
```

Remember to set your app name to `APP_NAME` environment.

## Run custom script before service started

We also support run custom script before service started such as migration or collect static files. Just add a bash script to `/server/script.sh`, the entrypoint script will execute this script if it exists.

Run migration and collect static before service started.
/server/script.sh
```
#!/bin/bash

python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic
```

# Implementation

## Image Structure
We use gunicorn to run django and use supervisor to hold gunciron process. And we also use nginx to be the proxy for the gunicorn.
We placed the django root directory to `/server`. Put nginx logs under `/opt/logs/nginx/`, gunicorn logs under `/opt/logs/gunicorn/`.

## Extend Image

Add `FROM wwtg99/docker-django` to the top of your Dockerfile.

## Build source codes to image

Add your django project to `/server` directory if you want to package your project in image.
If you have any requirements, add to `/server/requirements.txt`.

## Add another nginx server configuration file

Add any `*.conf` configuration files to `/etc/nginx/conf.d/`

```
COPY your_server.conf /etc/nginx/conf.d/
```

## Replace the default nginx server configuration file

Just add file to `/etc/nginx/conf.d/server.conf`

```
COPY your_server.conf /etc/nginx/conf.d/server.conf
```

## Replace the default nginx configuration file

Just add file to replace `/etc/nginx/nginx.conf`

```
COPY nginx.conf /etc/nginx/nginx.conf
```

## Add another supervisor program configuration file

Add any `*.conf` configuration files to `/etc/supervisor/conf.d/`

```
COPY your_program.conf /etc/supervisor/conf.d/
```

## Replace the default gunicorn configuration file

Just add file to replace `/etc/supervisor/conf.d/gunicorn.conf`

```
COPY your_program.conf /etc/supervisor/conf.d/gunicorn.conf
```

# Author
[wwtg99](http://52jing.wang)
