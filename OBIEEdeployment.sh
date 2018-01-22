#!/bin/bash
if [ $# -gt 0 ]; then
  TARGET_SERVER=$1
  WEBLOGIC_USER=$2
  WEBLOGIC_PWD=$3
  WEBLOGIC_SRC_URL=$4 #t3://server_name:port_number
  WEBLOGIC_TGT_URL=$5
  WEBLOGIC_PORT=9502
  CONNECTION_POOL_JSON_FILE=$1"ConnectionPools.json"
  RPD_VARIABLES_JSON_FILE=$1"rpdvariables.json"
  OBIEE_HOME="/app/obiee/Middleware/Oracle_Home"
  SCRIPT_HOME="/app/scripts/exportDir"
  DOMAIN_NAME="bi"
  echo $TARGET_SERVER
  echo "Export Target Connection Pools"
  $OBIEE_HOME/user_projects/domains/$DOMAIN_NAME/bitools/bin/datamodel.sh listconnectionpool -SI ssi -U $WEBLOGIC_USER -P $WEBLOGIC_PWD -S $TARGET_SERVER -N $WEBLOGIC_PORT -V true -O $SCRIPT_HOME/$CONNECTION_POOL_JSON_FILE
  echo "Export Target rpd Variables"
  $OBIEE_HOME/user_projects/domains/$DOMAIN_NAME/bitools/bin/datamodel.sh listrpdvariables -SI ssi -U $WEBLOGIC_USER -P $WEBLOGIC_PWD -S $TARGET_SERVER -N $WEBLOGIC_PORT -O $SCRIPT_HOME/$RPD_VARIABLES_JSON_FILE

  echo "Execute WLST Script and get BAR file from Source Server"
  cd $OBIEE_HOME/oracle_common/common/bin
  ./wlst.sh  $SCRIPT_HOME/backup_command.py $WEBLOGIC_USER $WEBLOGIC_PWD $WEBLOGIC_SRC_URL $WEBLOGIC_TGT_URL
  $OBIEE_HOME/user_projects/domains/$DOMAIN_NAME/bitools/bin/datamodel.sh updateconnectionpool -C $SCRIPT_HOME/$CONNECTION_POOL_JSON_FILE -SI ssi -U $WEBLOGIC_USER -P $WEBLOGIC_PWD -S $TARGET_SERVER -N $WEBLOGIC_PORT
  $OBIEE_HOME/user_projects/domains/$DOMAIN_NAME/bitools/bin/datamodel.sh updaterpdvariables -C $SCRIPT_HOME/$RPD_VARIABLES_JSON_FILE -U $WEBLOGIC_USER -P $WEBLOGIC_PWD -SI ssi -S $TARGET_SERVER -N $WEBLOGIC_PORT
  echo "WLST Script completed"
else
    echo "Target Server parameter not provided."
fi
