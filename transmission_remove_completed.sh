!#/bin/sh

export TRANSMISSION_WEB_HOME=/root/transmission/web
export LD_LIBRARY_PATH=/root/transmission   


TORRENTLIST=`/root/transmission/transmission-remote 127.0.0.1:9091 -l | sed -e "1d;$d;s/^ *//" | cut -s -d " " -f 1`

for TORRENTID in $TORRENTLIST
do
DL_COMPLETED=`/root/transmission/transmission-remote 127.0.0.1:9091 --torrent $TORRENTID --info | grep "Percent Done: 100%"`

if [ "$DL_COMPLETED" != "" ]; then
echo "Torrent #$TORRENTID is completed."
/root/transmission/transmission-remote 127.0.0.1:9091 --torrent $TORRENTID --stop
/root/transmission/transmission-remote 127.0.0.1:9091 --torrent $TORRENTID --remove
else
echo "Torrent #$TORRENTID is not completed. Ignoring"
fi
done
