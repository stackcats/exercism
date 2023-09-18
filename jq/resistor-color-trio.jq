def simplify(n):
  ["ohms", "kiloohms", "megaohms", "gigaohms"] as $arr
  | if . > 1000 then
    (. / 1000) | simplify(n + 1)
    else
    {
      value: .,
      unit: $arr[n]
    }
    end
;

{
    "black": 0,
    "brown": 1,
    "red": 2,
    "orange": 3,
    "yellow": 4,
    "green": 5,
    "blue": 6,
    "violet": 7,
    "grey": 8,
    "white": 9
} as $colors
| ($colors[.colors[0]] * 10 + $colors[.colors[1]]) * pow(10;$colors[.colors[2]])
| simplify(0)
