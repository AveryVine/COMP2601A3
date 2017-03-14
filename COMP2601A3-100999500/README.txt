COMP2601:   Assignment 2
Due Date:   March 15, 2017 (11:55pm)

Authors:    Alexei Tipenko (100995947)
            Avery Vine (100999500)

Program:    Tic tac toe game versus a computer, where the computer will play your move for you if you play too slowly

Testing instructions:
1) Click Product --> Build For --> Testing to ensure that the program is built for testing and not running
2) Ensure that "COMP2601A3-100999500Tests" is selected in the "COMP2601A3..." dropdown menu (on the top bar)
3) Open the "COMP2601A3-100999500Tests" folder on the sidebar
4) Select "COMP2601A3-100999500Tests.swift"
5) Click the diamond to the left of "class COMP2601A3_100999500Tests"

Operating instructions:
1) Click Product --> Build For --> Running to ensure that the program is built for running and not testing
2) Ensure that "COMP2601A3-100999500" is selected in the "COMP2601A3..." dropdown menu (on the top bar)
3) Click the Run button on the top bar

Notes on Computer AI:
- The computer AI makes use of the minimax algorithm, which recursively assigns values to each potential end game
- It assigns 10 points for a computer win, -10 points for a human win, and 0 points for a tie
- It takes that score and bumps it down the stack until it reaches the actual current state of the board
- It then chooses the move with the overall best total score
- Credit to http://neverstopbuilding.com/minimax for the algorithm and explanation
