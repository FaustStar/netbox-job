FROM netboxcommunity/netbox:latest

COPY ./local-packages /opt/netbox/local-packages

RUN ls /opt/netbox/local-packages

COPY ./plugin_requirements.txt /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install --no-warn-script-location --no-index --find-links=/opt/netbox/local-packages -r /opt/netbox/plugin_requirements.txt

COPY ./configuration/configuration.py /etc/netbox/config/configuration.py
COPY ./configuration/plugins.py /etc/netbox/config/plugins.py
RUN SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py collectstatic --no-input

RUN rm -rf /opt/netbox/local-packages