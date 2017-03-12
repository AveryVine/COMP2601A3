//
//  ViewController.swift
//  COMP2601A3-100999500
//
//  Created by Avery Vine on 2017-03-11.
//  Copyright © 2017 Avery Vine. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Observer {
    
    @IBOutlet var tile0: UIButton?
    @IBOutlet var tile1: UIButton?
    @IBOutlet var tile2: UIButton?
    @IBOutlet var tile3: UIButton?
    @IBOutlet var tile4: UIButton?
    @IBOutlet var tile5: UIButton?
    @IBOutlet var tile6: UIButton?
    @IBOutlet var tile7: UIButton?
    @IBOutlet var tile8: UIButton?
    @IBOutlet var label: UILabel?
    @IBOutlet var button: UIButton?
    
    var gameThread: DispatchQueue?
    var timer: DispatchSourceTimer?
    var game = Game()
    var xImage = UIImage(named: "x_button")
    var oImage = UIImage(named: "o_button")
    var emptyImage = UIImage(named: "empty_button")
    let strings = Strings()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUI()
        game.toggleActive()
        toggleClickListeners()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateMove(choice: Int) {
        updateSquareUI(choice: choice, playerTurn: game.getPlayerTurn())
        updateDisplayTextView(choice: choice)
    }
    
    
    func updateGameWinner(winner: Int) {
        gameOverUI(winner: winner)
    }
    
    
    @IBAction func startButtonOnClick() {
        if game.getActive() {
            game.toggleActive()
            gameOverUI(winner: Game.EMPTY_VAL)
            toggleClickListeners()
        }
        else {
            game = Game()
            self.game.attachObserver(observer: self)
            prepareUI()
            toggleClickListeners()
            gameLoop()
        }
    }
    
    func gameLoop() {
        gameThread = DispatchQueue(label: "gameThread", attributes: .concurrent)
        timer?.cancel()
        let computerMoveTask = DispatchWorkItem() {
            if !self.game.getActive() {
                self.timer?.cancel()
                self.timer = nil
            }
            let choice = self.game.randomSquare()
            self.game.makeMove(choice: choice)
            /*
            DispatchQueue.main.sync {
                self.updateSquareUI(choice: choice, playerTurn: self.game.getPlayerTurn())
                self.updateDisplayTextView(choice: choice)
            }
 */
            let gameWinner = self.game.gameWinner()
            if gameWinner == Game.EMPTY_VAL {
                self.game.switchPlayer()
                DispatchQueue.main.async {
                    self.toggleClickListeners()
                }
            }
            else {
                self.game.toggleActive()
                DispatchQueue.main.async {
                    //self.gameOverUI(winner: gameWinner)
                    self.timer?.cancel()
                    self.timer = nil
                }
            }
        }
        
        timer = DispatchSource.makeTimerSource(queue: gameThread)
        timer?.scheduleRepeating(deadline: .now() + .seconds(2), interval: .seconds(2))
        timer?.setEventHandler(handler: computerMoveTask)
        timer?.resume()
    }
    
    func updateSquareUI(choice: Int, playerTurn: Int) {
        var image: UIImage?
        if playerTurn == Game.X_VAL {
            image = xImage
        }
        else {
            image = oImage
        }
        switch choice {
        case 0:
            tile0?.setImage(image, for: UIControlState.normal)
            break
        case 1:
            tile1?.setImage(image, for: UIControlState.normal)
            break
        case 2:
            tile2?.setImage(image, for: UIControlState.normal)
            break
        case 3:
            tile3?.setImage(image, for: UIControlState.normal)
            break
        case 4:
            tile4?.setImage(image, for: UIControlState.normal)
            break
        case 5:
            tile5?.setImage(image, for: UIControlState.normal)
            break
        case 6:
            tile6?.setImage(image, for: UIControlState.normal)
            break
        case 7:
            tile7?.setImage(image, for: UIControlState.normal)
            break
        case 8:
            tile8?.setImage(image, for: UIControlState.normal)
            break
        default:
            print("Error setting button image")
        }
    }
    
    func updateDisplayTextView(choice: Int) {
        if choice == 0 { label?.text = strings.square0 }
        else if choice == 1 { label?.text = strings.square1 }
        else if choice == 2 { label?.text = strings.square2 }
        else if choice == 3 { label?.text = strings.square3 }
        else if choice == 4 { label?.text = strings.square4 }
        else if choice == 5 { label?.text = strings.square5 }
        else if choice == 6 { label?.text = strings.square6 }
        else if choice == 7 { label?.text = strings.square7 }
        else if choice == 8 { label?.text = strings.square8 }
    }
    
    func initUI() {
        button?.setTitle(strings.startButton_gameInactive, for: UIControlState.normal)
        label?.text = strings.displayTextView_gameInactive
        wipeSquares()
    }
    
    func prepareUI() {
        wipeSquares()
        button?.setTitle(strings.startButton_gameActive, for: UIControlState.normal)
        label?.text = strings.blank
    }
    
    func wipeSquares() {
        tile0?.setImage(emptyImage, for: UIControlState.normal)
        tile1?.setImage(emptyImage, for: UIControlState.normal)
        tile2?.setImage(emptyImage, for: UIControlState.normal)
        tile3?.setImage(emptyImage, for: UIControlState.normal)
        tile4?.setImage(emptyImage, for: UIControlState.normal)
        tile5?.setImage(emptyImage, for: UIControlState.normal)
        tile6?.setImage(emptyImage, for: UIControlState.normal)
        tile7?.setImage(emptyImage, for: UIControlState.normal)
        tile8?.setImage(emptyImage, for: UIControlState.normal)
    }
    
    func gameOverUI(winner: Int) {
        if winner == Game.X_VAL {
            label?.text = strings.x_winner
        }
        else if winner == Game.O_VAL {
            label?.text = strings.o_winner
        }
        else if winner == Game.TIE_VAL {
            label?.text = strings.tie_winner
        }
        else {
            label?.text = strings.no_winner
        }
        button?.setTitle(strings.startButton_gameInactive, for: UIControlState.normal)
    }
    
    func toggleClickListeners() {
        tile0?.isEnabled = !(tile0?.isEnabled)!
        tile1?.isEnabled = !(tile1?.isEnabled)!
        tile2?.isEnabled = !(tile2?.isEnabled)!
        tile3?.isEnabled = !(tile3?.isEnabled)!
        tile4?.isEnabled = !(tile4?.isEnabled)!
        tile5?.isEnabled = !(tile5?.isEnabled)!
        tile6?.isEnabled = !(tile6?.isEnabled)!
        tile7?.isEnabled = !(tile7?.isEnabled)!
        tile8?.isEnabled = !(tile8?.isEnabled)!
    }
    
    @IBAction func squareClicked(sender: UIButton) {
        timer?.cancel()
        timer = nil
        let choice = sender.tag
        game.makeMove(choice: choice)
        //updateSquareUI(choice: choice, playerTurn: game.getPlayerTurn())
        //updateDisplayTextView(choice: choice)
        let gameWinner = game.gameWinner()

        if gameWinner == Game.EMPTY_VAL {
            game.switchPlayer()
            gameLoop()
        }
        else {
            game.toggleActive()
            //gameOverUI(winner: gameWinner)
        }
        toggleClickListeners()
    }

}

