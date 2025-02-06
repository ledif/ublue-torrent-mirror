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
  "https://download.bazzite.gg/bazzite-stable.iso"
)

for url in "${urls[@]}"; do
  checksum_url="${url}-CHECKSUM"
  checksum=$(curl -L "$checksum_url" 2>/dev/null | awk '{print $1}')
  iso=$(basename "$url")
  echo "$iso $url $checksum"
done