/**
 * This is a simple JavaScript file for demonstration purposes.
 * It includes a class and a function that calculates the square of a number.
 */

/**
 * Represents a basic mathematical operation.
 * @class
 */
class MathOperation {
  /**
   * Calculates the square of a number.
   * @param {number} num - The input number.
   * @returns {number} The square of the input number.
   * @static
   */
  static square(num) {
    return num * num;
  }
}

/**
 * Main function to demonstrate the usage of the MathOperation class.
 * @param {number} input - The number to calculate the square of.
 */
function main(input) {
  const result = MathOperation.square(input);
  console.log(`The square of ${input} is: ${result}`);
}

// Example usage
main(5);

