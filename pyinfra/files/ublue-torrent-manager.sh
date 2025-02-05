#!/usr/bin/env bash
. ~/.bashrc
cd ~/ublue-torrent-mirror

mise use python@3.12
pip install torf
python3 -u ./libexec/ublue-torrent-manager.py