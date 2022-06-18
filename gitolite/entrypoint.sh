#!/bin/sh

set -e

readonly SSH_HOST_KEY='/etc/ssh/ssh_host_ed25519_key'

[ ! -f  "${SSH_HOST_KEY}" ] \
    && /usr/bin/ssh-keygen \
        -q \
        -t ed25519 \
        -f "${SSH_HOST_KEY}" \
        -N ''

cd /var/lib/git || exit 1

runuser --user git -- /usr/bin/gitolite setup \
    || runuser --user git -- /usr/bin/gitolite setup \
        --pubkey "${GITOLITE_ADMIN_PUBKEY:-/tmp/gitolite/admin.pub}"

exec /usr/sbin/sshd "${@}"
