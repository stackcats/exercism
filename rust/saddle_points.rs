fn is_largest_in_row(row: &Vec<u64>, n: &u64) -> bool {
    for x in row {
        if x > n {
            return false;
        }
    }
    true
}

fn is_smallest_in_col(input: &[Vec<u64>], col: usize, n: &u64) -> bool {
    for row in input.iter() {
        if &row[col] < n {
            return false;
        }
    }
    true
}

pub fn find_saddle_points(input: &[Vec<u64>]) -> Vec<(usize, usize)> {
    let mut res = vec![];
    for (i, row) in input.iter().enumerate() {
        for (j, n) in row.iter().enumerate() {
            if is_largest_in_row(row, n) && is_smallest_in_col(input, j, n) {
                res.push((i, j));
            }
        }
    }
    res
}
