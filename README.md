# About

Run [Etherpad](https://github.com/ether/etherpad-lite) inside a Docker container.
This variant of an Etherpad Docker container is characterized by:

* Using SQLite as data backend.
* Allow using persistent volumes for data, plugins and settings.
* Create administration user with configurable password.
* Uses latest Etherpad Lite _develop_ version.
* Allows to install another Etherpad Lite version (aka Git tag or branch).

# Usage

Start an Etherpad Lite instance listening on TCP port 9001:

```
docker run -p 9001:9001 fuerst/etherpad-lite
```

Set password for administration user named _admin_:

```
docker run -p 9001:9001 \
  -e ETHERPAD_ADMIN_PASSWORD='my-secret-password' \
  fuerst/etherpad-lite
```

Make plugins, database and settings persistent:

```
docker run -p 9001:9001 \
  -v /opt/etherpad-lite/var:/opt/etherpad-lite/var \
  -v /opt/etherpad-lite/node_modules:/opt/etherpad-lite/node_modules \
  fuerst/etherpad-lite
```

Run Etherpad Lite version 1.5.7:

```
docker run -p 9001:9001 \
  -e ETHERPAD_VERSION='1.5.7' \
  fuerst/etherpad-lite
```
