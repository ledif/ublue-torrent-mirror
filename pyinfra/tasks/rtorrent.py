from pyinfra.operations import files, pip, server
from pyinfra.facts.server import User
from pyinfra import host
from pathlib import Path

home = Path(host.get_fact(server.Home))
user = host.get_fact(User)

deployment_root = home / "ublue-torrent-mirror"
launch_script = deployment_root / "libexec" / "launch-rtorrent.sh"

files.put(
    name="Upload rtorrent.rc",
    src=f"files/rtorrent.rc",
    dest=str(home / ".rtorrent.rc"),
)

session_directory = home / ".rtorrent" / "session"
files.directory(
    name=f"Ensure the directory `{session_directory}` exists",
    path=session_directory
)

files.put(
    name="Upload launch-rtorrent.sh",
    src=f"files/launch-rtorrent.sh",
    dest=str(launch_script),
    mode="755"
)


server.crontab(
    name="Check if we need to launch rtorrent if it's not running every 5 minutes",
    user=user,
    command=f"/bin/bash {launch_script}",
    minute="*/5"
)
