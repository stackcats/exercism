def array_add:
  if length == 0 then 0
  else .[0] + (.[1:] | array_add) end
;

def array_reverse:
  if length == 0 then []
  else (.[1:] | array_reverse) + [.[0]] end
;

def array_map(f):
  if length == 0 then []
  else [(.[0] | f)] + (.[1:] | array_map(f)) end
;
