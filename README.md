# Universal Blue Torrent Mirror

This project contains the infrastructure and code to manage torrent mirroring of Universal Blue ISOs. For a full list of torrents, visit https://gaia.feralhosting.com/ublue.

## How To Add/Remove ISOs
> [!IMPORTANT] 
> This is designed for Universal Blue ISOs, which have the checksum files located at the ISO URL suffixed with `-CHECKSUM`. For example:
> - https://dl.getaurora.dev/aurora-stable.iso
> - https://dl.getaurora.dev/aurora-stable.iso-CHECKSUM
> If your ISOs don't follow this pattern, then this script will not work.

- Open a PR for adding or modifying lines in [`current-isos.sh`](https://github.com/ledif/ublue-torrent-mirror/blob/main/current-isos.sh).
