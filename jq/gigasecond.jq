def aux:
  if length == 10 then . + "T00:00:00" else . end + "Z"
;

.moment | aux | fromdate | . + 1e9 | todate | .[:-1]
