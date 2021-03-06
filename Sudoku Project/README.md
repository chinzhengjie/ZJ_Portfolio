# Sudoku Project

<br/>

## Introduction

I always found sudoku to be an intriguing puzzle because it is based on such simple concepts but yet, can become incredibly difficult to solve. Despite this, I felt that a game with such simple rules should be quite easy to automate. After a quick search online, I found that many people have already managed to accomplish this. Nevertheless, I was still very interested in trying to solve this myself. 

The idea of sudoku is quite simple. It is a 9x9 grid of numbers and there are only [5 rules](https://masteringsudoku.com/sudoku-rules-beginners/):

- Every square has to contain a single number
- Only the numbers from 1 through to 9 can be used
- Each 3×3 box can only contain each number from 1 to 9 once
- Each vertical column can only contain each number from 1 to 9 once
- Each horizontal row can only contain each number from 1 to 9 once

A common tactic to solve sudoku puzzles is to find a square which only has 1 possible number. From there, the rest of the puzzle will slowly become easier to solve. Thus, I tried to create a solver based on this logic.

<br/>

## Sudoku Solver v1

The way this function works is it will go through each square one by one and try to find a square with only one possible number. After it finds one, it fills it with that number and continues to loop through the entire puzzle repeatedly until it is solved. Two assumptions are made here (the function will check for them):

- the input is a python array
- the input array is the correct shape (9x9)

After working on the function for some time, I was glad that it finally worked. It was able to solve the easy sudoku puzzle.

(I created a function, draw_board, to better visualise the sudoku arrays and all images of the board are produced by this function.)

<img src="Images/Easy%20Puzzle%20(unsolved).PNG">  <img src="Images/Easy%20Puzzle%20(solved).PNG">

However, there was a flaw in this function, which was that it was unable to solve more complex puzzles. Essentially, if a puzzle did not have any square with only one possible number or the solver reaches a point where no such square exists, it will be unable to solve it. I tested this by simply removing a few numbers from the initial puzzle and we can see that the solver managed to fill out some squares but was unable to solve the entire puzzle.

<img src="Images/Hard%20Puzzle%20(unsolved).PNG">  <img src="Images/Hard%20Puzzle%20(failed).PNG">

Thus, this brought me to the Sudoku Solver v2.

<br/>

## Sudoku Solver v2

In more complex puzzles, if one were to reach a point where there were no squares with only one possible number, they would be forced to make a guess for some squares in order to progress in the puzzle. The goal was to create a solver able to do something similar to this. Thus, I found that a simple backtracking algorithm based on recursion was an effective way to solve puzzles.

After tweaking some parts in the original function, I managed to create a solver which goes through each square and tries to fill it with a possible number. Once it reaches a square with no possible answer, it will backtrack to the previous square and try other possible numbers. This proved to be very successful as it was able to solve both the easy and the hard puzzles. The only downside here is that the function can take slightly longer to solve certain puzzles due to the backtracking.

<img src="Images/Easy%20Puzzle%20(solved).PNG">  <img src="Images/Hard%20Puzzle%20(solved).PNG">


<br/>

## Sudoku Board Generator

Throughout the process of creating the Sudoku Solver, I found that one challenge I faced was creating the puzzles to test the function. There are plenty of puzzles online but copying them over to python was quite tedious. Thus, I had the idea of using the Sudoku Solver to create a function capable of producing random sudoku puzzles.

The Sudoku Board Generator function takes in one optional argument, "level", which ranges from 1 to 4 (1 being the easiest). It then creates a random solvable puzzle based on the level indicated. If no level is indicated, it will produce a random puzzle that could be from any level.

The function works as follows:

1. Create an empty 9x9 board of zeroes.

<img src="Images/Step%201%20(Board%20Generator).PNG">

2. Fill out 15 designated squares with random numbers and check that each number follows the rules of Sudoku.

<img src="Images/Step%202%20(Board%20Generator).PNG">

3. Utilise the solver to solve the puzzle.

<img src="Images/Step%203%20(Board%20Generator).PNG">

4. If the puzzle is solvable, "successful" is printed and "failed" is printed otherwise.

5. Randomly remove a number of filled squares depending on the difficulty of the puzzle required.

<img src="Images/Step%205%20(Board%20Generator).PNG">

6. Output an array.

<img src="Images/Final%20Output.PNG">


I found that 15 was an ideal number of squares to fill out because if there were too many numbers, the randomly generated board will often be unsolvable but at the same time, if there were too few numbers, the generated boards would not have much variety. 

As for the difficulty of the puzzles, these were based on the number of missing squares in each puzzle. For example, level 1 would have between 40 and 46 missing squares and level 4 would have between 59 and 63.

In order to test the function to make sure it was able to reliably generate solvable puzzles, I ran the function 2000 times. Fortunately, all 2000 times were successful, which meant that the function was working properly. Below are some examples of the puzzles that can be generated by the function.

Level 1 Puzzle <br/>
<img src="Images/Level%201%20%20Puzzle.PNG">

<br/>

Level 4 Puzzle <br/>
<img src="Images/Level%204%20%20Puzzle.PNG">

