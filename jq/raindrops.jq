.number as $in
| {"Pling": 3, "Plang": 5, "Plong": 7}
| to_entries
| map(select($in % .value == 0) | .key)
| add // $in
