defmodule Ledger do
  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @header %{
    en_US: "Date       | Description               | Change       \n",
    nl_NL: "Datum      | Omschrijving              | Verandering  \n"
  }

  @currency %{usd: "$", eur: "€"}

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(currency, locale, []), do: @header[locale]

  def format_entries(currency, locale, entries) do
    header = @header[locale]

    entries =
      Enum.sort_by(entries, &{&1.date.day, &1.description, &1.amount_in_cents})
      |> Enum.map(&format_entry(currency, locale, &1))
      |> Enum.join("\n")

    header <> entries <> "\n"
  end

  defp format_date(date, locale) do
    [y, m, d] =
      [date.year, date.month, date.day]
      |> Enum.map(&String.pad_leading("#{&1}", 2, "0"))

    format_date(y, m, d, locale)
  end

  defp format_date(y, m, d, :en_US), do: "#{m}/#{d}/#{y} "
  defp format_date(y, m, d, :nl_NL), do: "#{d}-#{m}-#{y} "

  defp format_entry(currency, locale, entry) do
    date = format_date(entry.date, locale)
    amount = format_amount(entry.amount_in_cents, currency, locale)

    description =
      if entry.description |> String.length() > 26 do
        " " <> String.slice(entry.description, 0, 22) <> "..."
      else
        " " <> String.pad_trailing(entry.description, 25, " ")
      end

    date <> "|" <> description <> " |" <> amount
  end

  @int_sep %{en_US: ",", nl_NL: "."}
  @decimal_sep %{en_US: ".", nl_NL: ","}

  defp format_amount(amount_in_cents, currency, locale) do
    decimal =
      amount_in_cents |> abs |> rem(100) |> to_string() |> String.pad_leading(2, "0")

    whole =
      abs(amount_in_cents)
      |> div(100)
      |> Stream.unfold(fn
        0 -> nil
        n -> {rem(n, 1000), div(n, 1000)}
      end)
      |> Enum.reverse()
      |> then(fn
        [] -> [0]
        xs -> xs
      end)
      |> Enum.join(@int_sep[locale])

    number = whole <> @decimal_sep[locale] <> decimal

    if amount_in_cents >= 0 do
      if locale == :en_US do
        "  #{@currency[currency]}#{number} "
      else
        " #{@currency[currency]} #{number} "
      end
    else
      if locale == :en_US do
        " (#{@currency[currency]}#{number})"
      else
        " #{@currency[currency]} -#{number} "
      end
    end
    |> String.pad_leading(14, " ")
  end
end
