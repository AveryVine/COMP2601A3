//
//  Game.swift
//  COMP2601A3-100999500
//
//  Created by Avery Vine on 2017-03-11.
//  Copyright © 2017 Avery Vine. All rights reserved.
//

import Foundation

class Game {
    
    static var X_VAL = 1, O_VAL = 2, TIE_VAL = 3, EMPTY_VAL = 0
    
    private var board = Array(repeating: 0, count: 9)
    private var playerTurn: Int
    private var active: Bool
    
    private var observerArray = [Observer]()
    
    
    
    /*----------
     - Description: constructor for the game
     - Input: none
     - Return: none
     ----------*/
    init() {
        active = true;
        playerTurn = Game.X_VAL
    }
    
    
    
    /*----------
     - Description: observable function that attaches an observer to the Game
     - Input: the observer to be attached
     - Return: none
     ----------*/
    func attachObserver(observer : Observer){
        observerArray.append(observer)
    }
    
    
    
    /*----------
     - Description: observable function that notifies all observers that a move was made
     - Input: the position of the move
     - Return: none
     ----------*/
    private func notifyMove(choice: Int) {
        for observer in observerArray {
            observer.updateMove(choice: choice)
        }
    }
    
    
    
    /*----------
     - Description: observable function that notifies all observers that the game is over
     - Input: the winner of the game
     - Return: none
     ----------*/
    private func notifyGameWinner(winner: Int) {
        for observer in observerArray {
            observer.updateGameWinner(winner: winner)
        }
    }
    
    
    
    /*----------
     - Description: select a random unoccupied square to make a move in
     - Input: none
     - Return: the selected square
     ----------*/
    func randomSquare() -> Int {
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
        notifyMove(choice: choice)
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
            notifyGameWinner(winner: playerTurn)
            return playerTurn;
        }
        for i in 0 ..< 9 {
            if (board[i] == Game.EMPTY_VAL) {
                return Game.EMPTY_VAL;
            }
        }
        notifyGameWinner(winner: Game.TIE_VAL)
        return Game.TIE_VAL;
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
     - Input: none
     - Return: various properties of Game
     ----------*/
    func getPlayerTurn() -> Int { return playerTurn; }
    func getActive() -> Bool { return active; }
    func toggleActive() { active = !active; }
    func getSquare(choice: Int) -> Int {return board[choice]; }
    
    /*----------
     - Description: prints the current state of the board (for debugging only)
     - Input: none
     - Return: none
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
