from pyinfra.operations import files, git, pip, server, systemd
from pyinfra import host
from pathlib import Path

home = Path(host.get_fact(server.Home))
deployment_root = home / "ublue-torrent-mirror"

for d in ["bin", "var/cache"]:
    files.directory(
        name="Ensure the directory `{}` exists".format(deployment_root / d),
        path=deployment_root / d,
    )

mise_path = str(deployment_root / "bin" / "mise")

files.download(
    name="Download mise",
    src="https://github.com/jdx/mise/releases/download/v2025.2.1/mise-v2025.2.1-linux-x64-musl",
    dest=mise_path
)

files.file(name="Ensure mise is executable", path=mise_path, mode="755")

files.line(
    name="Add mise hooks to bashrc",
    path=str(home / ".bashrc"),
    line='eval "$({} activate bash)"'.format(mise_path),
)
