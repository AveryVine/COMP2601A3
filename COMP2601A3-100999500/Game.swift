//
//  Game.swift
//  COMP2601A3-100999500
//
//  Created by Avery Vine on 2017-03-11.
//  Copyright © 2017 Avery Vine. All rights reserved.
//

import Foundation

class Game {
    
    //private var board = [Int]()
    private var board = Array(repeating: 0, count: 9)
    private var playerTurn: Int
    private var active: Bool
    
    
    /*----------
     - Description: constructor for game
     ----------*/
    init() {
        active = true;
        playerTurn = X_VAL
    }
    
    
    
    
    /*----------
     - Description: select a random UNOCCUPIED square to make a move in
     - Input: none
     - Return: the selected square
     ----------*/
    func randomSquare() -> Int {
        //let diceRoll = Int(arc4random_uniform(UInt32(6)))
        //var randInt = Int(arc4random_uniform(UInt32(9)));
        var choice = -1;
        repeat {
            choice = Int(arc4random_uniform(UInt32(9)));
        } while (board[choice] != EMPTY_VAL);
        return choice;
    }
    
    
    
    /*----------
     - Description: makes a move for the current player at the given square
     - Input: choice of square
     - Return: none
     ----------*/
    func makeMove(choice: Int) {
        board[choice] = playerTurn;
    }
    
    
    
    /*----------
     - Description: checks to see if anyone has won the game, or if the game has resulted in a tie
     - Input: none
     - Return: 1 (X wins), 2 (O wins), 3 (tie), or 0 (game not over)
     ----------*/
    func gameWinner() -> Int {
        if (checkForRow(0, 1, 2)
            || checkForRow(3, 4, 5)
            || checkForRow(6, 7, 8)
            || checkForRow(0, 3, 6)
            || checkForRow(1, 4, 7)
            || checkForRow(2, 5, 8)
            || checkForRow(0, 4, 8)
            || checkForRow(2, 4, 6)) {
            return playerTurn;
        }
        for i in 0 ..< 9 {
            if (board[i] == EMPTY_VAL) { return EMPTY_VAL; }
        }
        return TIE_WINNER;
    }
    
    

    /*----------
     - Description: checks to see if the provided row is complete
     - Input: the three squares in question
     - Return: complete or not complete
     ----------*/
    func checkForRow(square1: Int, square2: Int, square3: Int) -> Bool {
        if (board[square1] == board[square2]
        && board[square1] == board[square3]
            && board[square1] != EMPTY_VAL) {
            return true;
        }
        return false;
    }
    
    
    
    /*----------
     - Description: switches the active player
     - Input: none
     - Return: none
     ----------*/
    func switchPlayer() {
        playerTurn = (playerTurn == X_VAL ? O_VAL : X_VAL);
    }
    
    
    
    /*----------
     - Description: checks to see if the provided square is occupied
     - Input: the square to check
     - Return: occupied or not occupied
     ----------*/
    func squareOccupied(square: Int) -> Bool {
        return (board[square] == EMPTY_VAL) ? false : true;
    }
    
    
    
    /*----------
     - Description: getters
     ----------*/
    func getPlayerTurn() -> Int { return playerTurn; }
    func getActive() -> Bool { return active; }
    func toggleActive() { active = !active; }
    func getSquare(choice: Int) -> Int {return board[choice]; }
    
    /*----------
     - Description: prints the current state of the board
     ----------*/
    func printBoard() {
        for i in 0 ..< 3 {
            for j in 0 ..< 3 {
                print("\(board[i * 3 + j]) \t")
            }
        print("\n");
        }
    }
}
