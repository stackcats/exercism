def count:
  if . | test("[^ACGT]") then
    "Invalid nucleotide in strand" | halt_error
  else
    . | split("") | reduce .[] as $k ({"A":0,"C":0,"G":0,"T":0}; .[$k] += 1)
  end	   
;

.strand | count
