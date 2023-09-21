def aux:
  if (. | length) <= 1 then
    []
  else
    ["For want of a \(.[0]) the \(.[1]) was lost."] + (.[1:] | aux)
  end
;

.strings as $arr |
if $arr | length == 0 then
  []
else
  ($arr | aux) + ["And all for the want of a \($arr[0])."]
end
