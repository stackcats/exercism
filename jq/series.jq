if .series == "" then
  "series cannot be empty" | halt_error
elif .sliceLength > (.series | length) then
  "slice length cannot be greater than series length" | halt_error
elif .sliceLength == 0 then
  "slice length cannot be zero" | halt_error
elif .sliceLength < 0 then
  "slice length cannot be negative" | halt_error
else 
  .series as $series |
  .sliceLength as $sliceLength |
  [   range( ($series | length) - $sliceLength + 1 )
    | $series[ . : . + $sliceLength ]
  ]
end	       
