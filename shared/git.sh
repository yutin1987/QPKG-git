#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="git"

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi
    ln -nfs /opt/bin/git /usr/bin/git
    ln -nfs /opt/bin/git-cvsserver /usr/bin/git-cvsserver
    ln -nfs /opt/bin/git-receive-pack /usr/bin/git-receive-pack
    ln -nfs /opt/bin/git-shell /usr/bin/git-shell
    ln -nfs /opt/bin/git-upload-archive /usr/bin/git-upload-archive
    ln -nfs /opt/bin/git-upload-pack /usr/bin/git-upload-pack
    : ADD START ACTIONS HERE
    ;;
    
  stop)
    rm -f /usr/bin/git
    rm -f /usr/bin/git-cvsserver
    rm -f /usr/bin/git-receive-pack
    rm -f /usr/bin/git-shell
    rm -f /usr/bin/git-upload-archive
    rm -f /usr/bin/git-upload-pack
    : ADD STOP ACTIONS HERE
    ;;

  restart)
    $0 stop
    $0 start
    ;;

  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac

exit 0
