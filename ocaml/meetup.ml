open Base
open CalendarLib

type schedule = First | Second | Third | Fourth | Teenth | Last

type weekday =
  | Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday
  | Sunday

(* result type (year, month, day_of_month) *)
type date = int * int * int

let equal = function
  | Date.Mon, Monday
  | Tue, Tuesday
  | Wed, Wednesday
  | Thu, Thursday
  | Fri, Friday
  | Sat, Saturday
  | Sun, Sunday ->
      true
  | _ -> false

let meetup_day schedule weekday ~year ~month =
  let start = ref @@ Date.make year month 1
  and finish = Date.make year (month + 1) 1 in
  let dates = ref [] in
  while Date.(!start < finish) do
    if equal (Date.day_of_week !start, weekday) then
      dates := !dates @ [ !start ];
    start := Date.add !start (Date.Period.day 1)
  done;
  let ans =
    match schedule with
    | First -> List.hd_exn !dates
    | Second -> List.nth_exn !dates 1
    | Third -> List.nth_exn !dates 2
    | Fourth -> List.nth_exn !dates 3
    | Last -> List.last_exn !dates
    | _ -> List.find_exn !dates ~f:(fun d -> Date.day_of_month d >= 13)
  in
  Date.(year ans, int_of_month @@ month ans, day_of_month ans)
