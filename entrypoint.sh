#!/bin/bash
set -e

# Replace UID and GID
sed -i'' -e "s/^\(node:[^:]\):1000:1000:/\1:$USERID:$GROUPID:/" /etc/passwd
sed -i'' -e "s/^\(node:[^:]\):1000:/\1:$GROUPID:/" /etc/group
chown -R node:node /home/node
chown -R node:node /opt/etherpad-lite
cd /opt/etherpad-lite

# If a settings.json exists on a persistent volume: Make sure the
# container uses it.
if [ -f var/settings.json ]; then
  rm -f settings.json
  ln -s var/settings.json settings.json
fi

# Initial setup: Move our settings.json.master to var/ and symlink it back.
# Generate random session key as well as admin password.
if [ -f settings.json.master ] && [ ! -f var/settings.json ]; then
  rm -f settings.json
  mv settings.json.master var/settings.json
  ln -s var/settings.json settings.json
  # Replace sessionKey by something random.
  session_key=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
  sed -i'' -e "s/\"sessionKey\" : \"[^\"]*\"/\"sessionKey\": \"${session_key}\"/" /opt/etherpad-lite/var/settings.json
fi

# Replace standard admin password.
sed -i'' -e "s/\"password\": \"[^\"]*\"/\"password\": \"${ETHERPAD_ADMIN_PASSWORD}\"/" /opt/etherpad-lite/var/settings.json

# In case a host mounted volume does not contain nessecary Node.js modules
# like etherpad-lite itself or sqlite3 untar the nodes_module directory
# saved at container build time.
if [ ! -L node_modules/ep_etherpad-lite ] || [ ! -d node_modules/sqlite3 ]; then
  tar zxf node_modules.orig.tgz
fi

exec "$@"
