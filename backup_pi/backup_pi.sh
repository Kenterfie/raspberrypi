#!/bin/bash

TARGET="file:///mnt/backup/pi"
FILTER="--exclude /mnt --exclude /tmp --exclude /proc --exclude /sys"

IsIdle=$(curl -s -u xbmc:xbmc -X POST -H 'Content-type: application/json' -d '{"jsonrpc": "2.0", "method": "XBMC.GetInfoBooleans", "params": { "booleans": ["System.IdleTime(600) "] }, "id": 1}' http://localhost:8080/jsonrpc)
Video=$(curl -s -u xbmc:xbmc -X POST -H 'Content-type: application/json' -d '{"jsonrpc": "2.0", "method": "Player.GetItem", "params": {"playerid":1 }, "id": 1}' http://localhost:8080/jsonrpc)
Audio=$(curl -s -u xbmc:xbmc -X POST -H 'Content-type: application/json' -d '{"jsonrpc": "2.0", "method": "Player.GetItem", "params": {"playerid":0 }, "id": 1}' http://localhost:8080/jsonrpc)

echo $IsIdle
echo $Video
echo $Audio

if [[ "$IsIdle" =~ true ]]; then
    if [[ ! "$Video" =~ error || ! "$Audio" =~ error ]]; then
    # system idle but video oder audio active
        exit 0
    else
        duplicity incr --verbosity debug --no-encryption --full-if-older-than 2 --log-file=/var/log/backup.log --tempdir /tmp --exclude-if-present .nobackup --exclude-other-filesystems $FILTER / $TARGET
    fi
fi
