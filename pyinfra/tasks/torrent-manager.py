from pyinfra.operations import files, server
from pyinfra import host
from pathlib import Path

home = Path(host.get_fact(server.Home))

deployment_root = home / "ublue-torrent-mirror"

for ext in ["py", "sh"]:
    files.put(
        name="Upload ublue-torrent-mirror.py and shim",
        src=f"files/ublue-torrent-manager.{ext}",
        dest=str(deployment_root / "libexec" / f"ublue-torrent-manager.{ext}"),
        mode="755",
    )

for status in ["staged", "seeding", "trash"]:
    for iso_torrent in ["isos", "torrents"]:
        dir = deployment_root / "var" / iso_torrent / status
        files.directory(
            name=f"Ensure the directory {dir} exists",
            path=dir,
        )
