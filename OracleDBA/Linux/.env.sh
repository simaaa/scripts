#!/bin/bash

source /etc/profile
source /home/oracle/.bash_profile

if [ -z $MACHINE_NAME ]; then
  MACHINE_NAME=`hostname -s | tr '[a-z]' '[A-Z]'`
fi;

BASE_DIR=$(dirname $(readlink -f $0))
OWN_FILENAME=$(basename $0); OWN_FILENAME=${OWN_FILENAME%.*}
TODAY=`date +%Y%m%d`
TIMESTAMP=`date +"%Y.%m.%d. %H:%M:%S"`
CURRENTUSER=`id -nu`
SERVER_NAME=$MACHINE_NAME

LOG_FILE=$BASE_DIR/$OWN_FILENAME.log
LOG_FILE_WITH_DATE=$BASE_DIR/$OWN_FILENAME-$TODAY.log
ALERT_EMAIL=oradba@session.hu


#[[ ${BASH_SOURCE[0]} != $0  ]] && return || exit
if [ "$1" == "debugenv" ]; then
  echo "  BASE_DIR     = $BASE_DIR"
  echo "  OWN_FILENAME = $OWN_FILENAME"
  echo "  TODAY        = $TODAY"
  echo "  TIMESTAMP    = $TIMESTAMP"
  echo "  CURRENTUSER  = $CURRENTUSER"
  echo "  MACHINE_NAME = $MACHINE_NAME"
  echo "  LOG_FILE     = $LOG_FILE"
fi;
