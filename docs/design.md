# Design

## VPS
Currently using a £10 / month VPS from Feral Hosting
- Pros: 1TB of storage and 20 Gbit/s network with no usage limit
- Cons: non-root access with very old Debian 9 base

## Stack
- rtorrent to seed torrents (package provided by Feral)
- Supervisor to ensure rtorrent is running (no `systemd --user` available on VPS)
- `ublue-torrent-manager.py` which tracks changes in `current-isos.txt` and downloads ISOs / creates torrents / pushes torrent to repo


## Flow for creating new torrents
- A PR is merged which updates `current-isos.txt`
- The workflow `update-current-isos` runs and does the following
  - `rclone` is called to copy the new `current-isos.txt` file to the server.
  - ssh is used to call `ublue-torrent-manager.py` on the server
  - `ublue-torrent-manager.py` will create a torrent and push it back to the repo


## Why pyinfra over Ansible

Ansible requires that the host is running a somewhat recent version of python (i.e, can be EOL but not too far EOL).  `pyinfra` on the other hand only requires that the host has a POSIX-compatable shell. The VPSes in this sphere usually run very old operating systems with ancient python interpreters, lending itself more to `pyinfra`.
