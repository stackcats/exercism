def question:
  . | endswith("?")
;

def yell:
  . | test("[A-Z]") and (. | ascii_upcase) == .
;

def yell_question:
  (. | question) and (. | yell)
;

def silence:
  . == ""
;

def bob:
  if yell_question then "Calm down, I know what I'm doing!"
  elif yell then "Whoa, chill out!"
  elif question then "Sure."
  elif silence then "Fine. Be that way!"
  else "Whatever." end
;

.heyBob | gsub("\\s"; "") | bob
