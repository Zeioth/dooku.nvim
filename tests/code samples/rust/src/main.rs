// Before testing rustdoc, you must run "cargo init".
// Then you can generate the docs as "cargo rustdoc".
// Then you can find them in "target/doc"


/// Represents a basic mathematical operation.
pub struct MathOperation;

/// Calculates the square of a number.
impl MathOperation {
    pub fn square(num: i32) -> i32 {
        num * num
    }
}

/// Main function to demonstrate the usage of the MathOperation struct.
fn main() {
    let input = 5;
    let result = MathOperation::square(input);
    println!("The square of {} is: {}", input, result);
}

