# input: a floating point number
# output: the number rounded to two decimal places
def two_decimal: ((. * 100) | round) / 100;

31557600 as $sec |
{Earth: 1, Mercury: 0.2408467, Venus: 0.61519726,
Mars: 1.8808158, Jupiter: 11.862615, Saturn: 29.447498,
Uranus: 84.016846, Neptune: 164.79132} as $mp |
.planet as $planet |
if $mp | has($planet) then
  .seconds / $mp[$planet] / $sec | two_decimal
else
  "not a planet" | halt_error
end
  
  
