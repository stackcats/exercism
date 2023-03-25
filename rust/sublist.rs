#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

fn aux<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> bool {
    if _second_list.len() == 0 {
        return true;
    }
    for j in 0..=_second_list.len() - _first_list.len() {
        let mut res = true;
        for i in 0.._first_list.len() {
            if _first_list[i] != _second_list[j + i] {
                res = false;
                break;
            }
        }
        if res {
            return true;
        }
    }
    false
}

pub fn sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> Comparison {
    if _first_list.len() == _second_list.len() {
        if aux(_first_list, _second_list) {
            Comparison::Equal
        } else {
            Comparison::Unequal
        }
    } else if _first_list.len() < _second_list.len() {
        if aux(_first_list, _second_list) {
            Comparison::Sublist
        } else {
            Comparison::Unequal
        }
    } else {
        if aux(_second_list, _first_list) {
            Comparison::Superlist
        } else {
            Comparison::Unequal
        }
    }
}
