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
    func Game() {
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
}
