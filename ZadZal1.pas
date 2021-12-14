program ZadZal1;

var
  a:real;
  b:real;
  n:integer;
  resultRectangle:real;                                                         //I initialise variables with the prefix "result" to display the results nicely.
  resultTrapezium:real;
  resultSimpson:real;

procedure getData2;                                                             //The procedure will take the data and check if they are correct, if the data is wrong, the program will ask for the data again
begin
  writeln('Specify the interval of the calculation. It must be within the interval <0, pi>');
  write('Enter the value from which the program will start counting the integral: ');
  readln(a);
  while a < 0 do
  begin
    writeln('An incorrect value has been given. The start of the calculation must be greater than or equal to zero.');
    write('Enter the value from which the program will start counting the integral: ');
    readln(a);
  end;
  write('Enter the value at which the program stops counting the integral: ');
  readln(b);
  while b > Pi do
  begin
    writeln('An incorrect value has been given. The end of the calculation must be less than or equal to pi.');
    write('Enter the value at which the program stops counting the integral: ');
    readln(b);
  end;
  write('State how many segments you divide the given interval into: ');
  readln(n);
  while n <= 0 do
  begin
    writeln('The number of segments cannot be less than or equal to zero.');
    write('State how many segments you divide the given interval into: ');
    readln(n);
  end;
end;

function RectangleMethod(x:real; y:real):real;
var
  rectangleWidth:real;                                                          //I initialized the variables rectangleWidth and rectangleHeight to make the program more readable
  rectangleHeight:real;
  resultR:real;
  i:integer;                                                                    //variable used in the for loop
begin
  resultR := 0;
  rectangleWidth := (y - x)/n;
  for i:=0 to n do                                                              //the for loop will be executed as many times as declared by the user
  begin
    rectangleHeight := (sin(x+(rectangleWidth*i))+sin(x+(rectangleWidth*(i+1))))/2;
    resultR := resultR + (rectangleWidth*rectangleHeight);                      //assigns to the result variable the sum of the values of this result and the area under the graph for subsequent divisions
  end;
  RectangleMethod := resultR;
end;

function TrapeziumMethod(x:real; y:real):real;
var
  trapeziumHeight:real;                                                         //variables are declared to make the programme look clearer, they also make it easier to perform operations
  lengthA:real;
  lengthB:real;
  resultT:real;
  i:integer;
begin
  resultT := 0;
  trapeziumHeight := (y - x)/n;
  for i:=0 to n do
  begin
    lengthA := sin(x+trapeziumHeight*i);                                        //calculation of the bases of trapeziums
    lengthB := sin(x+trapeziumHeight*(i+1));
    resultT := resultT + ((lengthA + lengthB)*trapeziumHeight)/2                //assigns to the result variable the sum of the values of this result and the area under the graph for subsequent divisions
  end;
  TrapeziumMethod := resultT;
end;

function SimpsonMethod(x:real; y:real):real;
var
  distancePoints:real;
  divisionPoint:real;
  functionValue:real;
  resultS:real;
  i:integer;
begin
  resultS := 0;
  functionValue := 0;
  distancePoints := (y - x)/n;
  for i:=0 to n do
  begin
    divisionPoint := x + (i*distancePoints);
    functionValue := functionValue + sin(divisionPoint - (distancePoints/2));
    resultS := resultS + sin(divisionPoint);
  end;
  resultS := (distancePoints/6) * (sin(x) + sin(y) + (2*resultS) + (4*functionValue));
  SimpsonMethod := resultS;
end;

var
  c:real;
  p:real;
  Eps:real;
  MaxI:integer;
  resultIteration:real;                                                         //Initialises variables with the prefix "result" and "number" to display results nicely.
  resultRecurrence:real;
  iterationNumber:integer;
  recurrenceNumber:integer;

procedure getData3and4();                                                       //The procedure will take the data and check if they are correct, if the data is wrong, the program will ask for the data again
begin
  write('Give the number whose root you want to find: ');
  readln(c);
  while c < 0 do
  begin
    writeln('The program cannot find the root of a negative number. Give the number again: ');
    readln(c);
  end;
  write('Give the value of the first approximation ( your estimate of what number will be the root you are looking for): ');
  readln(p);
  while p < 0 do
  begin
    writeln('The approximation cannot be less than zero. Give it again: ');
    readln(p);
  end;
  write('Specify the precision with which the program should calculate the root: ');
  readln(Eps);
  while Eps < 0 do
  begin
    writeln('The approximation cannot be a negative number. Give the approximation again: ');
    readln(Eps);
  end;
  write('Specify the maximum number of iterations: ');
  readln(MaxI);
  while MaxI < 1 do
  begin
    writeln('The number of iterations cannot be less than 1. Give the number of iterations again: ');
    readln(MaxI);
  end;
end;

function SqrtIteration(sideA:real; sideB:real):real;
var
  i:integer;
begin
  for i:=0 to MaxI do
  begin
    if Abs(sideA - sideB) <= Eps then                                           //a condition that checks whether the square root has been found
    begin
      SqrtIteration := sideA;
      break;                                                                    //break makes the loop stop when the root of this number is found, not until MaxI
    end else
    begin                                                                       //instructions that continue to be executed until the square root is found
      sideA := (sideA + sideB)/2;
      sideB := c/sideA;
      SqrtIteration := sideA;                                                   //this instruction is needed to display the result when reaching MaxI
    end;
    iterationNumber := i;
  end;
end;

function SqrtRecurrence(sideA:real; sideB:real):real;
  begin
    if Abs(sideA-sideB) <= Eps then                                             //a condition that checks whether the square root has been found
    begin
      SqrtRecurrence := sideA;
    end
    else
    begin
      recurrenceNumber := recurrenceNumber + 1;
      if recurrenceNumber=MaxI then
      begin
        SqrtRecurrence := sideA;                                                // the instruction that will be executed when MaxI is reached
      end else
      begin
        SqrtRecurrence((sideA+sideB)/2, c/((sideA+sideB)/2));
      end;
    end;
  end;

begin
  writeln('The program calculates the integral from the function sin(x) using three methods.');
  getData2;
  resultRectangle := RectangleMethod(a, b);                                     //I assigned the values in this way to display them nicely on the screen and to make the code more readable
  resultTrapezium := TrapeziumMethod(a, b);
  resultSimpson := SimpsonMethod(a, b);
  writeln('The boundary values of the segment are <', a:0:2, ', ', b:0:2, '>.');
  writeln('This section is divided into ', n, ' equal parts.');
  writeln;
  writeln('--------------------------------------------------------------------------');
  writeln('The result of the integral calculated by the rectangle method is: ', resultRectangle:0:11);
  writeln('--------------------------------------------------------------------------');
  writeln;
  writeln('--------------------------------------------------------------------------');
  writeln('The result of the integral calculated by the trapezium method is: ', resultTrapezium:0:11);
  writeln('--------------------------------------------------------------------------');
  writeln;
  writeln('--------------------------------------------------------------------------');
  writeln('The result of the integral calculated by the Simpson method is: ', resultSimpson:0:11);
  writeln('--------------------------------------------------------------------------');
  writeln;
  writeln;
  writeln;
  writeln('The program finds the root of a given number using Newton-Raphson method in two ways.');
  getData3and4;
  resultIteration := SqrtIteration(p, c/p);
  writeln;
  writeln('---------------------------------------------------------------------------------------------------------------------');
  writeln('The square root of number ', c:0:8, ' calculated in an iterative manner is ', resultIteration:0:8, ' +- ', Eps:0:8);
  writeln('The number of iterations performed is: ', iterationNumber);
  writeln('The square of the calculated number is: ', (resultIteration*resultIteration):0:8);
  writeln('The difference a-x*x is: ', (c-(resultIteration*resultIteration)):0:8);
  writeln('---------------------------------------------------------------------------------------------------------------------');
  writeln;
  resultRecurrence := SqrtRecurrence(p, c/p);
  writeln('---------------------------------------------------------------------------------------------------------------------');
  writeln('The square root of number ', c:0:8, ' calculated by a recursive manner is ', resultRecurrence:0:8, ' +- ', Eps:0:8);
  writeln('The number of recurrences performed is: ', recurrenceNumber);
  writeln('The square of the calculated number is: ', (resultRecurrence*resultRecurrence):0:8);
  writeln('The difference a-x*x is: ', (c-(resultRecurrence*resultRecurrence)):0:8);
  writeln('---------------------------------------------------------------------------------------------------------------------');
  readln;
end.
