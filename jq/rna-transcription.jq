def to:
  if . == "G" then "C"
  elif . == "C" then "G"
  elif . == "T" then "A"
  else "U" end
;

def toRna:
  split("") | map(to) | join("")
;
