from datetime import date, timedelta


class MeetupDayException(ValueError):

    def __init__(self, message):
        self.message = message


DAY_MAP = {
    'Monday': 0,
    'Tuesday': 1,
    'Wednesday': 2,
    'Thursday': 3,
    'Friday': 4,
    'Saturday': 5,
    'Sunday': 6,
}


def meetup(year, month, week, day_of_week):
    dt = date(year, month, 1)
    target = DAY_MAP[day_of_week]
    arr = []

    next_month = month < 12 and date(year, month + 1, 1) or date(
        year + 1, 1, 1)

    while dt < next_month:
        if dt.weekday() == target:
            arr.append(dt)
        dt = dt + timedelta(days=1)

    indices = ['first', 'second', 'third', 'fourth', 'fifth']
    if week in indices:
        try:
            return arr[indices.index(week)]
        except:
            raise MeetupDayException('That day does not exist.')

    if week == 'last':
        return arr[-1]

    if week == 'teenth':
        for dt in arr:
            if 13 <= dt.day <= 19:
                return dt

    return arr[0]
