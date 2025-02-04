const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function add(x, y) {
    return x + y;
}

function subtract(x, y) {
    return x - y;
}

function multiply(x, y) {
    return x * y;
}

function divide(x, y) {
    if (y === 0) {
        return "Error! Division by zero.";
    }
    return x / y;
}

function calculator() {
    console.log("Select operation:");
    console.log("1. Add");
    console.log("2. Subtract");
    console.log("3. Multiply");
    console.log("4. Divide");
    console.log("5. Quit");

    rl.question("Enter your choice (1/2/3/4/5): ", function(choice) {
        if (choice === '5') {
            console.log("Thanks for using the calculator!");
            rl.close();
            return;
        }

        rl.question("Enter the first number: ", function(num1) {
            rl.question("Enter the second number: ", function(num2) {
                num1 = parseFloat(num1);
                num2 = parseFloat(num2);

                let result;
                switch (choice) {
                    case '1':
                        result = add(num1, num2);
                        console.log(`Result: ${num1} + ${num2} = ${result}`);
                        break;
                    case '2':
                        result = subtract(num1, num2);
                        console.log(`Result: ${num1} - ${num2} = ${result}`);
                        break;
                    case '3':
                        result = multiply(num1, num2);
                        console.log(`Result: ${num1} * ${num2} = ${result}`);
                        break;
                    case '4':
                        result = divide(num1, num2);
                        console.log(`Result: ${num1} / ${num2} = ${result}`);
                        break;
                    default:
                        console.log("Invalid choice. Please try again.");
                        break;
                }

                calculator();
            });
        });
    });
}

calculator();