def flatten:
  if length == 0 then
    []
  elif .[0] | type == "null" then
    (.[1:] | flatten)
  elif .[0] | type == "array" then
    (.[0] | flatten) + (.[1:] | flatten)
  else
    [.[0]] + (.[1:] | flatten) end
;  

.array | flatten
