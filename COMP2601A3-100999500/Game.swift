//
//  Game.swift
//  COMP2601A3-100999500
//
//  Created by Avery Vine on 2017-03-11.
//  Copyright © 2017 Avery Vine. All rights reserved.
//

import Foundation

class Game {
    
    //static final int X_VAL = 1, O_VAL = 2, TIE_WINNER = 3, EMPTY_VAL = 0;
    static var X_VAL = 1, O_VAL = 2, TIE_WINNER = 3, EMPTY_VAL = 0
    
    //private var board = [Int]()
    private var board = Array(repeating: 0, count: 9)
    private var playerTurn: Int
    private var active: Bool
    
    
    /*----------
     - Description: constructor for game
     ----------*/
    init() {
        active = true;
        playerTurn = Game.X_VAL
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
        } while (board[choice] != Game.EMPTY_VAL);
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
        if (checkForRow(square1: 0, square2: 1, square3: 2)
            || checkForRow(square1: 3, square2: 4, square3: 5)
            || checkForRow(square1: 6, square2: 7, square3: 8)
            || checkForRow(square1: 0, square2: 3, square3: 6)
            || checkForRow(square1: 1, square2: 4, square3: 7)
            || checkForRow(square1: 2, square2: 5, square3: 8)
            || checkForRow(square1: 0, square2: 4, square3: 8)
            || checkForRow(square1: 2, square2: 4, square3: 6)) {
            return playerTurn;
        }
        for i in 0 ..< 9 {
            if (board[i] == Game.EMPTY_VAL) { return Game.EMPTY_VAL; }
        }
        return Game.TIE_WINNER;
    }
    
    

    /*----------
     - Description: checks to see if the provided row is complete
     - Input: the three squares in question
     - Return: complete or not complete
     ----------*/
    func checkForRow(square1: Int, square2: Int, square3: Int) -> Bool {
        if (board[square1] == board[square2]
        && board[square1] == board[square3]
            && board[square1] != Game.EMPTY_VAL) {
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
        playerTurn = (playerTurn == Game.X_VAL ? Game.O_VAL : Game.X_VAL);
    }
    
    
    
    /*----------
     - Description: checks to see if the provided square is occupied
     - Input: the square to check
     - Return: occupied or not occupied
     ----------*/
    func squareOccupied(square: Int) -> Bool {
        return (board[square] == Game.EMPTY_VAL) ? false : true;
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
