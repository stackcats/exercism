.actual_minutes_in_oven //= 0
| .number_of_layers //= 1
| 40 as $expected_minutes_in_oven
| (2 * .number_of_layers) as $preparation_time
| 
{
  $expected_minutes_in_oven,
  "remaining_minutes_in_oven": ($expected_minutes_in_oven - .actual_minutes_in_oven),
  $preparation_time,
  "total_time": (.actual_minutes_in_oven + $preparation_time)
}
