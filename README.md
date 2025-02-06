# Universal Blue Torrent Mirror

To download a torrent, please visit https://gaia.feralhosting.com/ublue.

This project contains the infrastructure and code to manage torrent mirroring of Universal Blue ISOs. 

## How To Add/Remove ISOs
> [!IMPORTANT] 
> This is designed for Universal Blue ISOs, which have the checksum files located at the ISO URL suffixed with `-CHECKSUM`. For example:
> - https://dl.getaurora.dev/aurora-stable.iso
> - https://dl.getaurora.dev/aurora-stable.iso-CHECKSUM
> 
> If your ISOs don't follow this pattern, then this script will not work.

Simply add or modify lines in [`current-isos.sh`](https://github.com/ledif/ublue-torrent-mirror/blob/main/current-isos.sh) and open a PR.

## Development

If you are interested in how this project works or its design, please read [docs/design.md](https://github.com/ledif/ublue-torrent-mirror/blob/main/docs/design.md).
