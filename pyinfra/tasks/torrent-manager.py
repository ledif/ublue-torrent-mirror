from pyinfra.operations import files, server
from pyinfra.facts.server import User
from pyinfra import host
from pathlib import Path

home = Path(host.get_fact(server.Home))
user = host.get_fact(User)

deployment_root = home / "ublue-torrent-mirror"

for ext in ["py", "sh"]:
    files.put(
        name="Upload ublue-torrent-mirror.py and shim",
        src=f"files/ublue-torrent-manager.{ext}",
        dest=str(deployment_root / "libexec" / f"ublue-torrent-manager.{ext}"),
        mode="755",
    )

path_to_shim = deployment_root / "libexec" / "ublue-torrent-manager.sh"
server.crontab(
    name="Run ublue-torrent-mirror every 5 minutes",
    user=user,
    command=f"/bin/bash -c {path_to_shim}",
    minute="*/5"
)