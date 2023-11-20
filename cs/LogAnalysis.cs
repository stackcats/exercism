using System;

public static class LogAnalysis
{
    public static string SubstringAfter(this string s, string delimiter)
    {
        return s.Split(delimiter)[1];
    }

    public static string SubstringBetween(this string s, string start, string end)
    {
        int i = s.IndexOf(start) + start.Length;
        int j = s.IndexOf(end) - 1;
        return s.Substring(i, j - i + 1);
    }

    public static string Message(this string s)
    {
        return s.SubstringAfter(": ");
    }

    public static string LogLevel(this string s)
    {
        return s.SubstringBetween("[", "]");
    }
}
