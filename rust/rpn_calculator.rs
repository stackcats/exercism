#[derive(Debug)]
pub enum CalculatorInput {
    Add,
    Subtract,
    Multiply,
    Divide,
    Value(i32),
}

pub fn evaluate(inputs: &[CalculatorInput]) -> Option<i32> {
    let mut st = Vec::new();
    for input in inputs {
        match input {
            CalculatorInput::Value(n) => st.push(*n),
            CalculatorInput::Add => {
                if st.len() < 2 {
                    return None;
                }
                let b = st.pop().unwrap();
                let a = st.pop().unwrap();
                st.push(a + b);
            }
            CalculatorInput::Subtract => {
                if st.len() < 2 {
                    return None;
                }
                let b = st.pop().unwrap();
                let a = st.pop().unwrap();
                st.push(a - b);
            }
            CalculatorInput::Multiply => {
                if st.len() < 2 {
                    return None;
                }
                let b = st.pop().unwrap();
                let a = st.pop().unwrap();
                st.push(a * b);
            }
            CalculatorInput::Divide => {
                if st.len() < 2 {
                    return None;
                }
                let b = st.pop().unwrap();
                let a = st.pop().unwrap();
                st.push(a / b);
            }
        }
    }
    if st.len() != 1 {
        return None;
    }
    st.pop()
}
