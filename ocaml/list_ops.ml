let fold ~init ~f xs = List.fold_left f init xs
let length xs = List.length xs
let reverse xs = List.rev xs
let map ~f xs = List.map f xs
let filter ~f xs = List.filter f xs
let append xs ys = List.append xs ys
let concat = List.concat
