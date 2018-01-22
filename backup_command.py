import sys
import os
import time

timestr = time.strftime("%Y%m%d")
exportDir='/app/scripts/exportDir'
workDir='/app/scripts/workDir'
oracle_home='/app/obiee/Middleware/Oracle_Home'
domain_name='bi'
print 'Connecting to '+sys.argv[3]

connect(sys.argv[1],sys.argv[2],sys.argv[3]);
print 'Connected to '+sys.argv[3]
print 'Export BAR file from Source Server'
expcmdstr='exportServiceInstance(\'%s/user_projects/domains/%s\',\'ssi\',\'%s\',\'%s\',timestr)' % (oracle_home,domain_name,workDir,exportDir)
print 'Export Command String is: '+expcmdstr
exec expcmdstr
findstr="find "+exportDir+" -name \*.bar -type f | tail -1"
print 'Find String is: '+findstr
barfile=os.popen(findstr).read()
g = os.popen("chmod 644 "+barfile)
print 'Current BAR file is', barfile
disconnect();

connect(sys.argv[1],sys.argv[2],sys.argv[4]);
print 'Connected to '+sys.argv[4]
print 'Import BAR file to Target Server'
findstr="find "+exportDir+" -name \*.bar -type f | tail -1"
barfile=os.popen(findstr).read()
print 'BAR file to be used for import is', barfile
barfile=barfile.replace("\n","")
cmdstr='importServiceInstance(\'%s/user_projects/domains/%s\',\'ssi\',\'%s\',true,false,false)' % (oracle_home,domain_name,barfile)
print 'Command String is: '+cmdstr
exec cmdstr
disconnect();
exit()
