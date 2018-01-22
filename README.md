# OBIEEAutoDeployment
Automated Deployment of OBIEE rpd
The deployment scripts consist of a Shell script and a python script.

The scripts are executed by calling the shell script, OBIEEdeployment.sh passing 5 parameters:
1:  TARGET_SERVER (name of target server)
2:  WEBLOGIC_USER (WebLogic user with Admin rights)
3:  WEBLOGIC_PWD  (WebLogic user with Admin rights)
4:  WEBLOGIC_SRC_URL  (t3 URL of repository source server - e.g. t3://server_name:port_number)
5:  WEBLOGIC_TGT_URL  (t3 URL of repository target server - e.g. t3://server_name:port_number)

WEBLOGIC_PORT has been set to 9502. Change this value if necessary
CONNECTION_POOL_JSON_FILE sets the name of the .json file that stores the target connection pools
RPD_VARIABLES_JSON_FILE sets the name of the .json file that stores the target repository variables
OBIEE_HOME sets the name of the OBIEE Home directory
SCRIPT_HOME sets the name of the location of the script files
DOMAIN_NAME set the OBIEe domain name (defaulted to 'bi')

sample execution call:

./OBIEEdeployment.sh tgt_server weblogic Admin123 t3://src_server6:9500 t3://tgt_server:9500
