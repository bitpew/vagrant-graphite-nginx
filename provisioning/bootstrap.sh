#!/usr/bin/env bash

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y graphite-carbon graphite-web nginx-full uwsgi uwsgi-plugin-python

sudo cp /vagrant/provisioning/etc/default/graphite-carbon /etc/default/graphite-carbon
sudo cp /vagrant/provisioning/etc/carbon/carbon.conf /etc/carbon/carbon.conf
sudo cp /vagrant/provisioning/etc/carbon/storage-schemas.conf /etc/carbon/storage-schemas.conf
sudo cp /vagrant/provisioning/etc/graphite/local_settings.py /etc/graphite/local_settings.py
sudo cp /vagrant/provisioning/etc/uwsgi/apps-available/graphite-web.ini /etc/uwsgi/apps-available/graphite-web.ini
sudo cp /vagrant/provisioning/etc/nginx/sites-available/graphite-web /etc/nginx/sites-available/graphite-web

sudo ln -s /etc/uwsgi/apps-available/graphite-web.ini /etc/uwsgi/apps-enabled/graphite-web.ini
sudo ln -s /etc/nginx/sites-available/graphite-web /etc/nginx/sites-enabled/graphite-web

sudo update-rc.d carbon-cache defaults 95 10
sudo service carbon-cache start

sudo graphite-manage syncdb --noinput

sudo chmod 666 /var/lib/graphite/graphite.db
sudo chmod 755 /usr/share/graphite-web/graphite.wsgi

sudo service uwsgi restart
sudo service nginx restart
sudo service uwsgi restart
