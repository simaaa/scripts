SELECT
  rn.Name "Rollback Segment", rs.RSSize/1024 "Size (KB)",
  rs.Gets "Gets",
  rs.waits "Waits",
  (rs.Waits/rs.Gets)*100 "% Waits",
  rs.Shrinks "# Shrinks",
  rs.Extends "# Extends"
FROM v$rollname rn, v$rollstat rs, v$session s
WHERE rn.usn = rs.usn;
