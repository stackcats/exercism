raindrops <- function(number) {
  s <- ""
  if (number %% 3 == 0) {
    s <- paste(s, "Pling", sep = "")
  }
  if (number %% 5 == 0) {
    s <- paste(s, "Plang", sep = "")
  }
  if (number %% 7 == 0) {
    s <- paste(s, "Plong", sep = "")
  }
  if (s == "") {
    as.character(number)
  } else {
    s
  }
}

