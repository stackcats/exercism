use std::collections::HashMap;

pub struct School {
    mp: HashMap<u32, Vec<String>>,
}

impl School {
    pub fn new() -> School {
        Self { mp: HashMap::new() }
    }

    pub fn add(&mut self, grade: u32, student: &str) {
        self.mp
            .entry(grade)
            .or_insert(vec![])
            .push(student.to_string());
    }

    pub fn grades(&self) -> Vec<u32> {
        let mut gs = self.mp.keys().cloned().collect::<Vec<u32>>();
        gs.sort();
        gs
    }

    pub fn grade(&self, grade: u32) -> Vec<String> {
        let mut names = self.mp.get(&grade).unwrap_or(&vec![]).to_vec();
        names.sort();
        names
    }
}
