#!/bin/bash

# Start an empty project if no project
if [ ! -f "/server/manage.py" ]; then
    django-admin startproject server /server
fi
# Install requirements if requirements.txt exists
if [ -f "/server/requirements.txt" ]; then
    pip install -r /server/requirements.txt
fi
# Run other scripts
if [ -f "/script.sh" ]; then
    sh /script.sh
fi
# Start service
service nginx start
supervisord -c /etc/supervisor/supervisord.conf -n
