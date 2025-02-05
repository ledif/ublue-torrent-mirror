#!/usr/bin/env python3

import subprocess
from dataclasses import dataclass
from pathlib import Path
from torf import Torrent

DEPLOYMENT_ROOT = Path.home() / "ublue-torrent-mirror"

@dataclass
class CurrentISORecord:
    """Line of current-isos.txt"""
    name: str
    url: str
    sha: str

def read_current_isos_txt():
    current_isos = DEPLOYMENT_ROOT / "var/current-isos.txt"
    records = []
    with open(current_isos, "r") as f:
        for line in f.readlines():
            tokens = line.split()
            records.append(CurrentISORecord(tokens[0], tokens[1], tokens[2]))
    return records


class ISOTorrentPair:
    """Representation of torrent and ISO on disk"""
    def __init__(self, iso_name, iso_url, iso_sha):
        self.iso_name = iso_name
        self.iso_url = iso_url
        self.iso_sha = iso_sha
        self.torrent = Torrent()

    def download_iso(self):
        staged_iso_dir = DEPLOYMENT_ROOT / "var/isos/staged"
        cmd = ["aria2c", "-d", str(staged_iso_dir), self.iso_url]
        print(f"=== Running `{" ".join(cmd)}`")
        subprocess.run(cmd, check=True)


def stage_new_iso(iso):
    print("=== Staging seeding for", iso)
    p = ISOTorrentPair(iso.name, iso.url, iso.sha)
    p.download_iso()


def stop_seeding(sha):
    print("== Removing torrent for", sha)


def main():
    new_isos = read_current_isos_txt()
    current_seeding_shas = {}

    isos_to_start_seeding = [iso for iso in new_isos if iso.sha not in current_seeding_shas]
    for iso in isos_to_start_seeding:
        stage_new_iso(iso)

    new_iso_shas = set([iso.sha for iso in new_isos])
    shas_to_stop_seeding = [sha for sha in current_seeding_shas if sha not in new_iso_shas]

    for sha in shas_to_stop_seeding:
        stop_seeding(sha)

    if len(isos_to_start_seeding) == 0 and len(shas_to_stop_seeding):
        print("WARNING: no new torrents added or removed")

if __name__ == "__main__":
    main()


"""
ISO_DIR="/srv/isos"
TORRENT_DIR="/srv/torrents"
TRACKER_URL = "udp://tracker.opentrackr.org:1337/announce"
SEED_DIR="/srv/seed"

# Create torrents
for iso in "$ISO_DIR"/*.iso; do
    iso_name=$(basename "$iso")
    torrent_file="$TORRENT_DIR/${iso_name}.torrent"
    

        mktorrent -a "$TRACKER_URL" -o "$torrent_file" -c "$sha" "$iso"
done
"""