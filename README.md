# About

Run [Etherpad Lite](https://github.com/ether/etherpad-lite) inside a Docker container.
This variant of an Etherpad Docker container is characterized by:

At run time:

* Using SQLite as data backend.
* Allow using persistent volumes for data, plugins and settings.
* Allow running with specific uid and gid. Runs with uid/gid 1000 by default.
* Create administration user with configurable password.
* Using Abiword for import/export of DOC or PDF. ODF is not supported yet - it just crashes the abiword binary for unknown reason.

At image build time:

* By default it uses the latest Etherpad Lite 1.8.0 version.
* Allows to install another Etherpad Lite version (by Git tag or branch).

# Usage
---
**Start an Etherpad Lite instance listening on TCP port 9001**

```
docker run -p 9001:9001 kaergel/etherpad-lite
```
---
**Set password for administration user named _admin_**
```
docker run -p 9001:9001 \
  -e ETHERPAD_ADMIN_PASSWORD='my-secret-password' \
  kaergel/etherpad-lite
```
---
**Specify uid and gid (example 1111)**
```
docker run -p 9001:9001 \
  -e USERID=1111 \
  -e GROUPID=1111 \
  kaergel/etherpad-lite
```
---
**Make plugins, database and settings persistent**
```
docker run -p 9001:9001 \
  -v /opt/etherpad-lite/var:/opt/etherpad-lite/var \
  -v /opt/etherpad-lite/node_modules:/opt/etherpad-lite/node_modules \
  kaergel/etherpad-lite
```
---
**Build another version**
Only latest stable release (1.8.0) is available from hub.docker.com. You may build any other release you want by specifying an etherpad-lite branch or tag when building your own image:

```
docker build -e ETHERPAD_VERSION='1.7.5' .
```
