# Set up the Feral Hosting server
deploy:
  #!/bin/bash
  if [ ! -f id_ed25519_ublue_feral ]; then
    echo "Need private ssh key in id_ed25519_ublue_feral"
    exit 1
  fi

  podman build -t ublue-pyinfra .
  #podman run -it --volume $PWD:/app:Z -w /app/pyinfra ublue-pyinfra pyinfra --help
  podman run -it --volume $PWD:/app:Z -w /app/pyinfra ublue-pyinfra pyinfra -y inventory.py deploy.py

generate-current-isos:
  #!/usr/bin/env bash
  urls=(
    "https://dl.getaurora.dev/aurora-stable.iso"
    "https://dl.getaurora.dev/aurora-dx-stable.iso"
    "https://dl.getaurora.dev/aurora-nvidia-open-stable.iso"
    "https://dl.getaurora.dev/aurora-dx-nvidia-open-stable.iso"
    "https://dl.getaurora.dev/aurora-nvidia-stable.iso"
    "https://dl.getaurora.dev/aurora-dx-nvidia-stable.iso"
    "https://dl.getaurora.dev/aurora-hwe-latest.iso"
    "https://dl.getaurora.dev/aurora-dx-hwe-latest.iso"
    "https://dl.getaurora.dev/aurora-hwe-nvidia-open-latest.iso"
    "https://dl.getaurora.dev/aurora-dx-hwe-nvidia-open-latest.iso"
    "https://dl.getaurora.dev/aurora-hwe-nvidia-latest.iso"
    "https://dl.getaurora.dev/aurora-dx-hwe-nvidia-latest.iso"
  )

  for url in "${urls[@]}"; do
    checksum_url="${url}-CHECKSUM"
    checksum=$(curl -L "$checksum_url" 2>/dev/null | awk '{print $1}')
    iso=$(basename "$url")
    echo "$iso $url $checksum"
  done

test:
  #!/bin/bash
  set -x
  scp -i id_ed25519_ublue_feral pyinfra/files/ublue-torrent-manager.py ublue@gaia.feralhosting.com:ublue-torrent-mirror/libexec/ublue-torrent-manager.py
  ssh -i id_ed25519_ublue_feral ublue@gaia.feralhosting.com bash -c '~/ublue-torrent-mirror/libexec/ublue-torrent-manager.sh'
