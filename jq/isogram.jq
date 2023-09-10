.phrase 
| gsub("[^a-zA-Z]"; "") 
| ascii_downcase
| split("")
| reduce .[] as $key ({}; .[$key] += 1)
| all(. == 1)
