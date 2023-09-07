def letter_grade:
  if . < 60 then "F"
  elif . < 70 then "D"
  elif . < 80 then "C"
  elif . < 90 then "B"
  else "A" end
;

def count_letter_grades:
  reduce .[] as $score ({A: 0, B: 0, C: 0, D: 0, F: 0}; .[($score | letter_grade)] += 1)
;
