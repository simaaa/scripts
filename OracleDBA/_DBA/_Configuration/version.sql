select t.* from v$version t;

/*
export PATH=$ORACLE_HOME/OPatch:$PATH
clear && opatch version && opatch lsinventory
clear && opatch prereq CheckConflictAgainstOHWithDetail -ph ./
clear && opatch apply
*/
