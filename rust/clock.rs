#[derive(Debug)]
pub struct Clock {
    hours: i32,
    minutes: i32,
}

impl Clock {
    pub fn new(mut hours: i32, mut minutes: i32) -> Self {
        while minutes < 0 {
            minutes += 60;
            hours -= 1;
        }
        while hours < 0 {
            hours += 24;
        }
        hours += minutes / 60;
        let c = Clock {
            hours: hours % 24,
            minutes: minutes % 60,
        };
        c
    }

    pub fn add_minutes(self, minutes: i32) -> Self {
        Clock::new(self.hours, self.minutes + minutes)
    }

    pub fn to_string(self) -> String {
        format!("{:02}:{:02}", self.hours, self.minutes)
    }
}

impl PartialEq for Clock {
    fn eq(&self, other: &Clock) -> bool {
        self.hours == other.hours && self.minutes == other.minutes
    }
}
