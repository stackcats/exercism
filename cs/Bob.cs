using System;
using System.Text.RegularExpressions;

public static class Bob
{
    public static string Response(string statement)
    {
        statement = statement.Trim();
        if (statement == "")
            return "Fine. Be that way!";

        bool hasLetter = Regex.IsMatch(statement, @"[a-zA-Z]");
        bool isQuestion = statement.EndsWith("?");
        bool isYelling = hasLetter && statement.ToUpper() == statement;
        if (isQuestion && isYelling)
            return "Calm down, I know what I'm doing!";
        if (isQuestion)
            return "Sure.";
        if (isYelling)
            return "Whoa, chill out!";
        return "Whatever.";
    }
}
