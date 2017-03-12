//
//  Observer.swift
//  COMP2601A3-100999500
//
//  Created by Alexei Tipenko on 2017-03-12.
//  Copyright © 2017 Avery Vine. All rights reserved.
//

import Foundation

protocol Observer {
    func updateMove(choice: Int)
    func updateGameWinner(winner: Int)
}
