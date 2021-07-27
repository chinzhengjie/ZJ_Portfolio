# Sudoku Project

### Introduction

A sudoku solver is known to be a relatively simple project to work on so I thought I would be apt to make this one of my first projects. The idea of sudoku is quite simple. It is a 9x9 grid of numbers ranging from 1 to 9 and there are only [5 rules](https://masteringsudoku.com/sudoku-rules-beginners/):

- Every square has to contain a single number
- Only the numbers from 1 through to 9 can be used
- Each 3×3 box can only contain each number from 1 to 9 once
- Each vertical column can only contain each number from 1 to 9 once
- Each horizontal row can only contain each number from 1 to 9 once

### Sudoku Solver v1
- board must be an array and must be 9x9
- premise is to go through each square in the puzzle and find possible numbers to fill it with
- find the square with only 1 possible number and fill it first
- loop through the entire puzzle multiple times until it is solved
- uses the a, b, c functions

pitfalls of v1
- can only solve simple puzzles that actually have a square with only 1 possible number
- essentially can't solve complex puzzles


## Sudoku Solver v2
- incorporates majority of the functions in v1
- tweak some parts of v1
- added "empty space" function to find empty spaces on the board
- utilises a backtracking algorithm to solve the puzzle
- goes through each square and tries to fill it with a possible number
- once it reaches a square with no possible answer, it will backtrack to the previous square and try other possible numbers
- manges to solve any solvable sudoku puzzle

pitfalls of v2
- can take a long time to solve certain puzzles due to the backtracking


## Sudoku Board Generator
- by utilising the solver, we can create a random sudoku puzzle of varying levels of difficulty (levels 1-4, with 1 being the easiest and the default covers all levels)
- (difficulty is based on the number of missing squares)
- the function creates a blank board and fills out 15 numbers randomly 
- (15 is a good number because if too many numbers are filled out, an unsolvable puzzle will be created and the function will fail.)
- (if too few numbers are filled out, the generate puzzles will turn out too similar to each other)
- uses the solver to solve the rest of the board
- randomly removes a random number of squares depending on difficulty
- this creates a sudoku puzzle
- if a board is generated successfully, it will print "successful"

in order to test the function, i ran the function 2000 times to ensure that it would not produce an unsolvable board
all 2000 times were successful -> reasonable to believe it will always produce a solvable board














