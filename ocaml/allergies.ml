type allergen =
  | Eggs
  | Peanuts
  | Shellfish
  | Strawberries
  | Tomatoes
  | Chocolate
  | Pollen
  | Cats

let allergenScores =
  [
    (Eggs, 1);
    (Peanuts, 2);
    (Shellfish, 4);
    (Strawberries, 8);
    (Tomatoes, 16);
    (Chocolate, 32);
    (Pollen, 64);
    (Cats, 128);
  ]

let allergic_to n a = List.assoc a allergenScores |> ( land ) n |> ( <> ) 0

let allergies n =
  List.filter_map
    (fun (a, _) -> if allergic_to n a then Some a else None)
    allergenScores
