# -*- coding: utf-8 -*-
from datetime import datetime
from functools import cmp_to_key


class LedgerEntry:

    def __init__(self, date: str, description: str, change: int):
        self.date = datetime.strptime(date, '%Y-%m-%d')
        self.description = description
        self.change = change

    def format_date(self, locale: str) -> str:
        date_fmt = locale == 'nl_NL' and '%d-%m-%Y' or '%m/%d/%Y'
        return self.date.strftime(date_fmt)

    def format_description(self, width: int) -> str:
        if len(self.description) > width:
            return f'{self.description[:width-3]}...'
        else:
            return self.description.ljust(width)

    def format_change(self, currency: str, locale: str, width: int) -> str:
        integer = abs(self.change) // 100
        integer_str = '0'
        if integer > 0:
            integer_parts = []
            while integer > 0:
                integer_parts.insert(0, str(integer % 1000))
                integer = integer // 1000
            delimiter = locale == 'en_US' and ',' or '.'
            integer_str = delimiter.join(integer_parts)

        decimal = abs(self.change) % 100

        dot_delimiter = locale == 'en_US' and '.' or ','

        sign = currency == 'USD' and '$' or u'€'

        if locale == 'en_US':
            s = f'{sign}{integer_str}{dot_delimiter}{decimal:02}'
            if self.change < 0:
                s = f'({s})'
            else:
                s = f'{s} '
        else:
            if self.change < 0:
                integer_str = f'-{integer_str}'
            s = f'{sign} {integer_str}{dot_delimiter}{decimal:02} '

        return s.rjust(width, ' ')


def create_entry(date, description, change) -> LedgerEntry:
    return LedgerEntry(date, description, change)


def cmp(e1, e2):
    t1 = (e1.date, e1.description, e1.change)
    t2 = (e2.date, e2.description, e2.change)
    return bool(t1 > t2) - bool(t1 < t2)


def gen_header(titles):
    return [t.ljust(w) for (t, w) in zip(titles, (10, 25, 13))]


def format_entries(
    currency: str,
    locale: str,
    entries: list[LedgerEntry],
) -> str:
    titles = ['Date', 'Description', 'Change'] if locale == 'en_US' else [
        'Datum', 'Omschrijving', 'Verandering'
    ]

    rows = []
    rows.append(' | '.join(gen_header(titles)))

    entries.sort(key=cmp_to_key(cmp))

    for entry in entries:
        row = [
            entry.format_date(locale),
            entry.format_description(25),
            entry.format_change(currency, locale, 13),
        ]

        rows.append(' | '.join(row))

    return '\n'.join(rows)
