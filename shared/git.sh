#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="git"

PATH_GIT=/mnt/ext/opt/git
BIN_PATH=/bin

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi
    ln -nfs $PATH_GIT/git $BIN_PATH/git
    ln -nfs $PATH_GIT/git-cvsserver $BIN_PATH/git-cvsserver
    ln -nfs $PATH_GIT/git-receive-pack $BIN_PATH/git-receive-pack
    ln -nfs $PATH_GIT/git-shell $BIN_PATH/git-shell
    ln -nfs $PATH_GIT/git-upload-archive $BIN_PATH/git-upload-archive
    ln -nfs $PATH_GIT/git-upload-pack $BIN_PATH/git-upload-pack
    : ADD START ACTIONS HERE
    ;;
    
  stop)
    rm -f $BIN_PATH/git
    rm -f $BIN_PATH/git-cvsserver
    rm -f $BIN_PATH/git-receive-pack
    rm -f $BIN_PATH/git-shell
    rm -f $BIN_PATH/git-upload-archive
    rm -f $BIN_PATH/git-upload-pack
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
