pub fn find(array: &[i32], key: i32) -> Option<usize> {
    if array.len() == 0 {
        return None;
    }
    let mut l = 0;
    let mut r = array.len() - 1;
    while l <= r {
        let mid = l + (r - l) / 2;
        if array[mid] == key {
            return Some(mid);
        }
        if array[mid] < key {
            l = mid + 1;
        } else {
            if mid == 0 {
                break;
            }
            r = mid - 1;
        }
    }
    None
}
