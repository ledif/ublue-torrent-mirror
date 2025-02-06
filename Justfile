# Set up the Feral Hosting server
##[group('Devel')]
deploy:
  #!/bin/bash
  if [ ! -f id_ed25519_ublue_feral ]; then
    echo "Need private ssh key in id_ed25519_ublue_feral"
    exit 1
  fi

  podman build -t ublue-pyinfra .
  podman run -it --volume $PWD:/app:Z -w /app/pyinfra ublue-pyinfra pyinfra -y inventory.py deploy.py

deploy-gh:
  #!/bin/bash
  echo "$SSH_KEY" > id_ed25519_ublue_feral
  chmod 600 id_ed25519_ublue_feral
  cd pyinfra
  pyinfra -y inventory.py deploy.py

##[group('Devel')]
# Copy local version of ublue-torrent-manager.py to server and run it
update-and-trigger-torrent-manager:
  #!/bin/bash
  set -x
  scp -i id_ed25519_ublue_feral pyinfra/files/ublue-torrent-manager.py ublue@gaia.feralhosting.com:ublue-torrent-mirror/libexec/ublue-torrent-manager.py
  ssh -i id_ed25519_ublue_feral ublue@gaia.feralhosting.com bash -c '~/ublue-torrent-mirror/libexec/ublue-torrent-manager.sh'
