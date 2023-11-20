using System;

static class LogLine
{
    public static string Message(string logLine)
    {
        int i = logLine.IndexOf(" ");
        return logLine.Substring(i + 1).Trim();
    }

    public static string LogLevel(string logLine)
    {
        int i = logLine.IndexOf("]");
        return logLine.Substring(1, i - 1).ToLower();
    }

    public static string Reformat(string logLine)
    {
        return $"{Message(logLine)} ({LogLevel(logLine)})";
    }
}
