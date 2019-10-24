#!/bin/sh

set -o errexit
set -o nounset
set -o pipefail

# Load libraries
. /scripts/liblog.sh
. /scripts/libasap.sh

print_welcome_page

apk add --no-cache curl git && cd /tmp && \
curl -sfL https://install.goreleaser.com/github.com/tj/node-prune.sh | sh -s -- -b /usr/local/bin

find /app -type d -exec chmod 755 {} \;
find /app -type f -exec chmod 644 {} \;

info "Install PM2 & rimraf globaly"
npm install pm2 -g

### Check if a directory exist ###
if [ -d "/app/${PROJECT_DIR}" ] 
then
  info "Change directory to ${PROJECT_DIR}"
  cd /app/${PROJECT_DIR}
  info "npm install"
  npm install
  info "yarn cache clean && node-prune"
  node-prune
  info "npm run build-${BUILD_FLAG}"
  npm run build-${BUILD_FLAG}
  info "++++++++++++++ Ready for PM2 ++++++++++++++"
else 
  warn "Directory project not found."
  exit 1
fi

# Call command issued to the docker service
exec "$@"
