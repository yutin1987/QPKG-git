#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="git"

PATH_GIT=/mnt/ext/opt/git
PATH_BIN=/usr/bin

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi
    ln -nfs $PATH_GIT/git $PATH_BIN/git
    ln -nfs $PATH_GIT/git-cvsserver $PATH_BIN/git-cvsserver
    ln -nfs $PATH_GIT/git-receive-pack $PATH_BIN/git-receive-pack
    ln -nfs $PATH_GIT/git-shell $PATH_BIN/git-shell
    ln -nfs $PATH_GIT/git-upload-archive $PATH_BIN/git-upload-archive
    ln -nfs $PATH_GIT/git-upload-pack $PATH_BIN/git-upload-pack
    : ADD START ACTIONS HERE
    ;;
    
  stop)
    rm -f $PATH_BIN/git
    rm -f $PATH_BIN/git-cvsserver
    rm -f $PATH_BIN/git-receive-pack
    rm -f $PATH_BIN/git-shell
    rm -f $PATH_BIN/git-upload-archive
    rm -f $PATH_BIN/git-upload-pack
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
