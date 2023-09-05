def is_valid_command:
  . | test("^chatbot\\W"; "i")
;

def remove_emoji:
  . | gsub("emoji\\d+"; "")
;

def check_phone_number:
  if . | test("\\(\\+\\d{2}\\) \\d{3}-\\d{3}-\\d{3}") then
    "Thanks! Your phone number is OK."
    else
      "Oops, it seems like I can't reach out to \(.)."
      end
;

def get_domains:
  . | [scan("\\w+\\.\\w+")]
;

def nice_to_meet_you:
  .
  | capture("My name is (?<name>[-\\w]+)"; "i")
  | "Nice to meet you, \(.name)"
	     
;

def parse_csv:
  . | split(",\\s*"; "")
;
