# Task 1: calculate the production rate per hour
def production_rate_per_hour:
  . * 221 * (
      if . <= 4 then
	1
      elif . <= 8 then
	0.9
      elif . == 9 then
	0.8
      else
	0.77
	end
    )
;

# Task 2: calculate the number of working items produces per minute
def working_items_per_minute:
  (. | production_rate_per_hour) / 60 | floor
;


.speed | (production_rate_per_hour, working_items_per_minute)
