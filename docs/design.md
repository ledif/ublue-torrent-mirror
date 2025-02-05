# Design

## VPS
Using a £10 / month VPS on Feral Hosting
- Pros: 20 Gb network with no usage limit
- Cons: non-root access with very old Debian 9 base

## Stack
- supervisord for managing user-level services (no `systemd --user` available on VPS)
- rtorrent to seed torrents
- daemon to watch current_isos.txt for changes and create/remove torrents


## Creating new torrents
- Open a PR to add a new line to current_isos.txt

Once merged, a workflow copies current_isos.txt to the VPS
