open Base

type callback_id = int

type 'a kind =
  | Input
  | Cp1 of ('a -> 'a) * 'a cell
  | Cp2 of ('a -> 'a -> 'a) * 'a cell * 'a cell

and 'a cell = {
  value : 'a ref;
  children : 'a cell list ref;
  callbacks : (callback_id, 'a -> unit) Hashtbl.t;
  next_callback_id : callback_id ref;
  kind : 'a kind;
  eq : 'a -> 'a -> bool;
}

let create ~kind ~value ~eq =
  {
    value = ref value;
    children = ref [];
    callbacks = Hashtbl.create (module Int);
    kind;
    eq;
    next_callback_id = ref 0;
  }

let create_input_cell ~value ~eq = create ~kind:Input ~value ~eq

let rec value_of { kind; value; _ } =
  match kind with
  | Input -> !value
  | Cp1 (f, c) -> f (value_of c)
  | Cp2 (f, c1, c2) -> f (value_of c1) (value_of c2)

let rec propagate cell =
  let v = value_of cell in
  if not (cell.eq v !(cell.value)) then (
    cell.value := v;
    Hashtbl.iter cell.callbacks ~f:(fun cb -> cb v);
    List.iter !(cell.children) ~f:propagate)

let set_value { value; children; eq; _ } v =
  if not (eq !value v) then (
    value := v;
    List.iter !children ~f:propagate)

let create_compute_cell_1 c ~f ~eq =
  let cell = create ~kind:(Cp1 (f, c)) ~value:(f (value_of c)) ~eq in
  c.children := !(c.children) @ [ cell ];
  cell

let create_compute_cell_2 c1 c2 ~f ~eq =
  let cell =
    create ~kind:(Cp2 (f, c1, c2)) ~value:(f (value_of c1) (value_of c2)) ~eq
  in
  c1.children := !(c1.children) @ [ cell ];
  c2.children := !(c2.children) @ [ cell ];
  cell

let add_callback { callbacks; next_callback_id; _ } ~k =
  let id = !next_callback_id in
  Hashtbl.add_exn callbacks ~key:id ~data:k;
  next_callback_id := Int.succ id;
  id

let remove_callback { callbacks } id = Hashtbl.remove callbacks id
