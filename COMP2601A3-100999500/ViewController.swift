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
    var game = Game()
    var xImage = UIImage(named: "x_button")
    var oImage = UIImage(named: "o_button")
    var emptyImage = UIImage(named: "empty_button")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButtonOnClick() {
        if game.getActive() {
            game.toggleActive()
            gameOverUI(winner: Game.EMPTY_VAL)
            toggleClickListeners()
        }
        else {
            game = Game()
            prepareUI()
            toggleClickListeners()
            gameLoop()
        }
    }
    
    func gameLoop() {
        gameThread = DispatchQueue(label: "gameThread", attributes: .concurrent)
        gameThread?.async {
            while self.game.getActive() {
                sleep(2)
                let choice = self.game.randomSquare()
                self.game.makeMove(choice: choice)
                DispatchQueue.main.sync {
                    self.updateSquareUI(choice: choice, playerTurn: self.game.getPlayerTurn())
                    self.updateDisplayTextView(choice: choice)
                }
                let gameWinner = self.game.gameWinner()
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
        }
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
        gameThread?.suspend()
        let choice = sender.tag
        game.makeMove(choice: choice)
        updateSquareUI(choice: choice, playerTurn: game.getPlayerTurn())
        updateDisplayTextView(choice: choice)
        let gameWinner = game.gameWinner()
        if gameWinner == Game.EMPTY_VAL {
            game.switchPlayer()
            gameLoop()
        }
        else {
            game.toggleActive()
            gameOverUI(winner: gameWinner)
        }
        toggleClickListeners()
    }

}

