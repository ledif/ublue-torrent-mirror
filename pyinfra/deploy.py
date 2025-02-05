from os import path

from pyinfra import host, local

tasks = ["mise", "torrent-manager"]
for task in tasks:
    local.include(filename=path.join("tasks", f"{task}.py"))
