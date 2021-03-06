# Nero

## Introduction ##
* The Nero progrogramming language will be a simple, yet typed programming language aimed mostly for young users to expose them to what programming is. A lexer and a parser will be created using Flex and Yacc in C, in order to develop the wanted programming language. The language will be simple, fun, and useful for many science classes that every kid has to go through. The program will have a gamma of functions that will help with the day to day school activities of today’s future and they will be able to do all kinds of mathematical equations inside of it.

## Motivations & Reasons ##
* There are many young students from seventh through twelfth grade that love using computers, and are interested in learning more about them.The constant use of technology is something that is growing every day more and more. For this reason, the main goal of the Nero programming language is on those students who like the idea of programming and would like to learn the basics of programming. In many schools, there is no presence at all of any programming. With Nero, the plans are to design a simple, useful programming language that will help kids through their science assignments and at the same time expose them to the new world of programming languages. The more programmers we have, the better for our future. 

## Features ##
* One of the most important features of our programming language is that users will have the ability to enter the help command. Once given, the program will list the list of features available in our programming language, including all the functions that the users can use.
* The programming language will allow users to use either int or float variables. However, for the sake of simplicity and better understanding, the int variables will be converted to float variables. 
* Users will have the ability to print a string, term or an expression with the print command.
* The programming language will store users defined variables, their type and their value. Users will be able to assign and re-assign values and use those variables in any kind of mathematical expressions. For example:
```
int x = 6;
print x;
// This would print 6
x = x + 4;
print x;
// This would print 10;
```

* We will allow the following mathematical expressions:
    * Addition: ```int x = 3 + 6 + 5;```
    * Subtraction:```float y = 4 - 5 - 3;```
    * Multiplication: ```float z = 4 * 3 * 3;```
    * Division: ```float a = 4.2 / 3.5;```
    * Power: ```float b = 4^3;```
    * Square Roots: ```float c = square_root(4); ```
    * Sine: ```float d = sin(90);```
    * Cosine: ```float e = cos(0);```
    * Tangent: ```float f = tan(1);```
    * Mathematical expressions in parenthesis: ```float g = (3 + 5) * (4 + 5.2);```
    * Elaborate mathematical expressions: ```float h = 3^2 + 5 + (3/2.5) - 4;```

* Now for the main feature of our programming language, we will have several functions that the users will be able to use for their daily science activities. The functions are the following:
    * Calculate the area of a triangle. Given a base and a height, the function will return the area of the wanted triangle.
         * ```float calc_tri_area(float base, float height);```
    * Calculate the area of a rectangle. Given the length and width of a rectangle, the program will calculate the area.
         * ```float calc_rect_area(float length, float width);```
    * Calculate the area of a circle. Given the radius of the circle, the program will calculate the area of a circle.
         * ```float calc_circ_area(float radius);```
    * Calculate the volume of a rectangle. Given the length, width and height of the rectangle, the program will calculate the volume.
         * ```float calc_vol_rect(float length, float width, float height);```
    * Calculate the volume of a sphere. Given the radius of a sphere, the program will calculate the volume.
         * ```float calc_vol_sphere(float radius);```
    * Calculate the volume of a cylinder. Given the radius and height of a cylinder, the program will calculate the volume.
         * ```float calc_vol_cyl(float radius, float height);```
    * Calculate the roots of a quadratic equation. Given the equation: ax^2 + bx + c = 0, and using those constants, a, b and c, the program will print the real roots, if any and it will return the amount of roots the quadratic equation has.
         * ```float find_roots(float a, float b, float c); ```
    * Calculate the circumference of a circle. Given the radius, the PL will calculate the circumference of a circle.
         * ```float calc_circ_circum(float radius);```
    * Calculate the force given mass and acceleration.
         * ```float calc_force(float mass, float acceleration);```
    * Calculate the voltage given a current and a resistance.
         * ```float calc_voltage(float current, float resistance);```

## Technologies Used ##
* Basic C
* Lex/Flex
* YACC/Bison

## How to install and run Nero ##
* We can use the app Flex Windows (Yacc and Lex) to compile the programming language. Alternatively, a makefile can be used to compile the code.
```
all: nero

nero.tab.c nero.tab.h:    nero.y
    bison -t -v -d nero.y

lex.yy.c: nero.l nero.tab.h
    flex nero.l

nero: lex.yy.c nero.tab.c nero.tab.h
    gcc -o nero nero.tab.c lex.yy.c

clean:
    rm nero nero.tab.c lex.yy.c nero.tab.h nero.output
```

* Once the executable has been created, then we can just call it through the command prompt: nero and start typing code, or using the nero < filename call in Windows or ./ciel filename in Linux environments to run a piece of code in a text file. 
* A tutorial on how to instal and use nero can be found at: https://drive.google.com/file/d/1Ex21cNjm64bEerPzCdzMAb3JrR7IjLrr/view?usp=sharing

## Challenges and what's next ##
* Creating a programming language from nothing was an extremely challenging task, as I had no idea where to start, but after being suggested to use Flex and Bison, it was slightly easier. The idea of having programming blocks and functions is still something that's complex, and I would like to expand my program to capture those.  With that said, overall I feel extremely successful with this project, as completely new technologies were learned to be able to accomplish everything that we wanted to accomplish. I sincerely think that a simple programming language like this one can help a lot of early students to enjoy what programming is, and all the benefits that it can give them. See how powerful they are, and how many amazing things they can make with it. For next steps, if I had the chance, I would demo this to a group of young students, and get their input and talk about what new functions and features they would like to have in Nero.
