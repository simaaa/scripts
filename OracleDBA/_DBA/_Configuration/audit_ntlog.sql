select
  x.ksppinm   name,
  y.ksppstvl  value,
  decode(ksppity,1,'BOOLEAN',2,'STRING',3,'INTEGER', 4,'PARAMETER FILE',5,'RESERVED',6,'BIG INTEGER','UNKNOWN') typ,
  decode(ksppstdf,'TRUE','DEFAULT VALUE','FALSE','***SPECIFIED IN INIT.ORA')                                    isdefault,  
  decode(bitand(ksppiflg/256,1),1,'***CAN BE CHANGED WITH ALTER SESSION','FALSE')                               isses_modifiable,  
  decode(bitand(ksppiflg/65536,3),1,'CAN BE CHANGED IMMEDIATELY WITH ALTER SYSTEM',
    2,'***CAN BE CHANGED WITH ALTER SYSTEM, CHANGES TAKE EFFECT IN SUBSEQUENT SESSIONS',
    3,'***CAN BE CHANGED IMMEDIATELY WITH ALTER SYSTEM','FALSE')                                                issys_modifiable,
  decode(bitand(ksppstvf,7),1,'WAS MODIFIED WITH ALTER SESSION',4,'***WAS MODIFIED WITH ALTER SYSTEM','FALSE')  is_modified,  
  decode(bitand(ksppstvf,2),2,'***ORACLE CHANGED THE VALUE ON STARTUP','FALSE')                                 is_adjusted,  
  ksppdesc    description, 
  ksppstcmnt  update_comment      
from x$ksppi x,  x$ksppcv y 
where x.indx = y.indx 
and x.inst_id = userenv('Instance') 
and y.inst_id = userenv('Instance') 
and x.ksppinm like '%ntlog_events%'
order by x.ksppinm;

-- ALTER SYSTEM SET "_disable_ntlog_events"=FALSE SCOPE=SPFILE;
