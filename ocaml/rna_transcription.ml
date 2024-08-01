type dna = [ `A | `C | `G | `T ]
type rna = [ `A | `C | `G | `U ]

let rec to_rna = function
  | [] -> []
  | `G :: ds -> `C :: to_rna ds
  | `C :: ds -> `G :: to_rna ds
  | `T :: ds -> `A :: to_rna ds
  | `A :: ds -> `U :: to_rna ds
  | _ -> failwith "error"
