# Universal Blue Torrent Mirror

## Why pyinfra over Ansible

Ansible requires that the host is running a somewhat recent version of python (i.e, EOL but not too far EOL).  `pyinfra` on the other hand only requires that the host has a POSIX-compatable shell. The VPSes in this sphere usually run very old operating systems with ancient python interpreters, which lends itself more to `pyinfra`.
