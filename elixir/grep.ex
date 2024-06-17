defmodule Grep do  
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    pattern = if "-x" in flags, do: "^#{pattern}$", else: pattern
    opts = if "-i" in flags, do: "i", else: ""
    r = Regex.compile!(pattern, opts)
    show_filename = length(files) > 1
    show_linenum = "-n" in flags
    invert = "-v" in flags
    
    files
    |> Enum.map(fn file ->
      content = File.read!(file)
      if "-l" in flags do
        if xor(Regex.match?(r, content), invert) do
          "#{file}\n"
        else
          ""
        end
      else
        content
        |> String.trim("\n")
        |> String.split("\n")
        |> Enum.with_index(1)
        |> Enum.reduce("", fn {line, i}, acc ->
          if xor(Regex.match?(r, line), invert) do
            line = if show_linenum, do: "#{i}:#{line}", else: line
            line = if show_filename, do: "#{file}:#{line}", else: line
            acc <> "#{line}\n"
          else
            acc
          end
        end)
      end
    end)
    |> Enum.join("")
  end

  defp xor(true, false), do: true
  defp xor(false, true), do: true
  defp xor(_, _), do: false
end

