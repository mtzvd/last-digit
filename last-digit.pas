program step_mod_last_digit;
{The program asks the user for two positive integers a and b and determines the last digit of the result of calculating a^b}

{Define a type to represent the result - a digit}
type
    digit = 0..9;
    
{Define the main global variables. Considering that the initial conditions specify that a and b are positive integers, it's possible to use the word type for them. However, when using values of a and b close to the maximum value for this type, the result of the expression a^b can be too large. To avoid this, we'll refrain from directly calculating the expression a^b and in the function, which could calculate the value of a^b, we will calculate mod 10 at each step - such a substitution is mathematically possible}

var 
    a, b: word; 

{The function step_mod(x,y : word) calculates the last digit of x^y given that x and y are positive integers. No input parameter check is performed}
function step_mod (x, y : word) : digit;
    var 
        i: word; {Iteration index}

begin
    {Set the initial result value}
    step_mod := 1; 
    {Perform calculations in a loop}
    for i := 1 to y do 
        step_mod := step_mod*x mod 10;
end;

{The function read_valid(var_name: string) : word - prompts user's input with var_name, reads and checks the user's input for compliance with the conditions and returns the last correctly entered value}
function read_valid(var_name: string): word;
var 
    input: word;
begin
    {Initialize input}
    input:=0;
    {Request and validate the user's input}
    repeat
        {Display input prompt for the user}
        write('Enter the value for ', var_name, ' (1 - 65,535) : ');
        {Disable standard input/output error handling, to check the value manually and not terminate the program if the user makes a mistake}
        {$I-}
        {Read the entered value into variable a}
        readln(input);
        {Re-enable standard input/output error handling}
        {$I+}
        {Check for input/output errors and that the value of a is within the required range. If there is at least one error, display an error message and reset the variable so the user can enter it again}
        if (IOResult <> 0) or (input <= 0) or (input > 65535) then 
            begin
                writeln('Incorrect value for ', var_name, ' (expected a positive integer no more than 65535)');
                input :=0
            end;
    until (input > 0) and (input <= 65535);
    {Return input to function}
    read_valid := input;
end;


begin
{Initialize variables}
a := 0;
b := 0;

{Display information about the program}
writeln('Given positive integers a and b. The program determines the last digit of the result of the expression a^b calculation.');
writeln;

{Request and validate the user's input for number a}
a := read_valid('a');

{Request and validate the user's input for number b}
b := read_valid('b');

{Display the result}
writeln;
writeln('The last digit of a^b : ', step_mod(a, b))

end.
