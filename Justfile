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

