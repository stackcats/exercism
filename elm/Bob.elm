module Bob exposing (hey)


hey : String -> String
hey remark =
    let
        trim_remark =
            String.trim remark

        is_question =
            String.endsWith "?" trim_remark

        only_letters =
            String.filter Char.isAlpha trim_remark

        is_yelling =
            only_letters /= "" && String.all Char.isUpper only_letters

        is_silence =
            trim_remark == ""
    in
    if is_silence then
        "Fine. Be that way!"

    else if is_yelling && is_question then
        "Calm down, I know what I'm doing!"

    else if is_question then
        "Sure."

    else if is_yelling then
        "Whoa, chill out!"

    else
        "Whatever."
