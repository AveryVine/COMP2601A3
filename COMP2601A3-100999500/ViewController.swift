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
        if true /*game.getActive()*/ {
            /*game.toggleActive()*/
            gameOverUI(winner: 0) /*gameOverUI(winner: EMPTY_VAL)*/
            toggleClickListeners()
        }
        else {
            
        }
    }
    
    func initUI() {
        button?.setTitle("Start", for: UIControlState.normal)
        label?.text = ("Press button to start!")
    }
    
    func gameOverUI(winner: Int) {
        if winner == 1 { /*X_VAL*/
            
        }
        else if winner == 2 { /*O_VAL*/
            
        }
        else if winner == 3 { /*TIE_VAL*/
            
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

}

