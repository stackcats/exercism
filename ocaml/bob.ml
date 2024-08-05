open Base

let response_for s =
  let s = String.strip s in
  let letters = String.filter s ~f:Char.is_alpha in
  let is_question = String.is_suffix s ~suffix:"?" in
  let is_yelling =
    (not (String.is_empty letters))
    && String.equal (String.uppercase letters) letters
  in
  if String.is_empty s then "Fine. Be that way!"
  else if is_question && is_yelling then "Calm down, I know what I'm doing!"
  else if is_question then "Sure."
  else if is_yelling then "Whoa, chill out!"
  else "Whatever."
