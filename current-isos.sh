#!/usr/bin/env bash

set -ou pipefail

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
  "https://download.projectbluefin.io/bluefin-stable.iso"
  "https://download.projectbluefin.io/bluefin-dx-stable.iso"
  "https://download.projectbluefin.io/bluefin-nvidia-stable.iso"
  "https://download.projectbluefin.io/bluefin-dx-nvidia-stable.iso"
  "https://download.bazzite.gg/bazzite-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-nvidia-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-nvidia-open-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-gnome-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-gnome-nvidia-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-gnome-nvidia-open-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-deck-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-deck-gnome-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-ally-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-ally-gnome-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-asus-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-gnome-asus-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-asus-nvidia-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-gnome-asus-nvidia-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-asus-nvidia-open-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-gnome-asus-nvidia-open-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-surface-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-gnome-surface-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-surface-nvidia-open-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-gnome-surface-nvidia-open-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-deck-nvidia-stable-amd64.iso"
  "https://download.bazzite.gg/bazzite-deck-nvidia-gnome-stable-amd64.iso"
)

for url in "${urls[@]}"; do
  checksum_url="${url}-CHECKSUM"
  checksum_req=$(curl --fail -L "$checksum_url" 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    echo "ERROR: request for $checksum_url returned an error code"
    echo "$checksum_req"
    exit 1
  fi
  iso=$(basename "$url")
  checksum=$(echo "$checksum_req" | awk '{print $1}')
  echo "$iso $url $checksum"
done
