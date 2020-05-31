SELECT
  TO_CHAR(t.first_time,'YYYY.MM.DD.') DAY,
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'00',1,0)),'99') "00",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'01',1,0)),'99') "01",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'02',1,0)),'99') "02",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'03',1,0)),'99') "03",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'04',1,0)),'99') "04",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'05',1,0)),'99') "05",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'06',1,0)),'99') "06",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'07',1,0)),'99') "07",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'08',1,0)),'99') "08",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'09',1,0)),'99') "09",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'10',1,0)),'99') "10",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'11',1,0)),'99') "11",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'12',1,0)),'99') "12",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'13',1,0)),'99') "13",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'14',1,0)),'99') "14",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'15',1,0)),'99') "15",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'16',1,0)),'99') "16",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'17',1,0)),'99') "17",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'18',1,0)),'99') "18",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'19',1,0)),'99') "19",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'20',1,0)),'99') "20",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'21',1,0)),'99') "21",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'22',1,0)),'99') "22",
  TO_CHAR(SUM(DECODE(TO_CHAR(t.first_time,'HH24'),'23',1,0)),'99') "23"
FROM v$log_history t
GROUP BY TO_CHAR(t.first_time,'YYYY.MM.DD.')
ORDER BY 1;
