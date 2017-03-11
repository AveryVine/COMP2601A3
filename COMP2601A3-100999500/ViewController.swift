//
//  ViewController.swift
//  COMP2601A3-100999500
//
//  Created by Avery Vine on 2017-03-11.
//  Copyright © 2017 Avery Vine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    @IBAction func startButtonOnClick() {
        print("Start button clicked")
        if game.getActive() {
            print("Ending current game")
            game.toggleActive()
            gameOverUI(winner: Game.EMPTY_VAL)
            toggleClickListeners()
        }
        else {
            print("Starting new game")
            game = Game()
            prepareUI()
            toggleClickListeners()
            gameLoop()
        }
    }
    
    func gameLoop() {
        print("In game loop")
        gameThread = DispatchQueue(label: "gameThread", attributes: .concurrent)
        timer?.cancel()
        let computerMoveTask = DispatchWorkItem() {
            if !self.game.getActive() {
                self.timer?.cancel()
                self.timer = nil
            }
            let choice = self.game.randomSquare()
            print("Computer made a choice")
            self.game.makeMove(choice: choice)
            print("Computer made a move")
            DispatchQueue.main.sync {
                self.updateSquareUI(choice: choice, playerTurn: self.game.getPlayerTurn())
                self.updateDisplayTextView(choice: choice)
                print("UI updated by computer")
            }
            let gameWinner = self.game.gameWinner()
            print("Chose a winner: \(gameWinner)")
            if gameWinner == Game.EMPTY_VAL {
                self.game.switchPlayer()
            }
            else {
                self.game.toggleActive()
                DispatchQueue.main.async {
                    self.gameOverUI(winner: gameWinner)
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
        if choice == Game.X_VAL {
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
        label?.text = "Button \(choice) pressed."
    }
    
    func initUI() {
        button?.setTitle("Start", for: UIControlState.normal)
        label?.text = ("Press button to start!")
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
    
    func prepareUI() {
        tile0?.setImage(emptyImage, for: UIControlState.normal)
        tile1?.setImage(emptyImage, for: UIControlState.normal)
        tile2?.setImage(emptyImage, for: UIControlState.normal)
        tile3?.setImage(emptyImage, for: UIControlState.normal)
        tile4?.setImage(emptyImage, for: UIControlState.normal)
        tile5?.setImage(emptyImage, for: UIControlState.normal)
        tile6?.setImage(emptyImage, for: UIControlState.normal)
        tile7?.setImage(emptyImage, for: UIControlState.normal)
        tile8?.setImage(emptyImage, for: UIControlState.normal)
        button?.setTitle("Running", for: UIControlState.normal)
        label?.text = ""
    }
    
    func gameOverUI(winner: Int) {
        if winner == Game.X_VAL {
            
        }
        else if winner == Game.O_VAL {
            
        }
        else if winner == Game.TIE_VAL {
            
        }
        else {
            
        }
        button?.setTitle("Start", for: UIControlState.normal)
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
        print("Suspending thread...")
        timer?.cancel()
        print("Thread suspended")
        let choice = sender.tag
        print("Choice is \(choice)")
        game.makeMove(choice: choice)
        print("Made a move")
        updateSquareUI(choice: choice, playerTurn: game.getPlayerTurn())
        updateDisplayTextView(choice: choice)
        print("Updated the UI")
        let gameWinner = game.gameWinner()
        print("Checked for a winner: \(gameWinner)")
        if gameWinner == Game.EMPTY_VAL {
            print("No winner yet")
            game.switchPlayer()
            print("Switched players")
            timer = nil
            print("Set thread to nil")
            gameLoop()
            print("New Game loop started")
        }
        else {
            print("Found a winner!")
            game.toggleActive()
            gameOverUI(winner: gameWinner)
        }
        toggleClickListeners()
    }

}

