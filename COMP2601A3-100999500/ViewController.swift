//
//  ViewController.swift
//  COMP2601A3-100999500
//
//  Created by Avery Vine on 2017-03-11.
//  Copyright © 2017 Avery Vine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView0: UIImageView?
    @IBOutlet var imageView1: UIImageView?
    @IBOutlet var imageView2: UIImageView?
    @IBOutlet var imageView3: UIImageView?
    @IBOutlet var imageView4: UIImageView?
    @IBOutlet var imageView5: UIImageView?
    @IBOutlet var imageView6: UIImageView?
    @IBOutlet var imageView7: UIImageView?
    @IBOutlet var imageView8: UIImageView?
    @IBOutlet var label: UILabel?
    @IBOutlet var button: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUI();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButtonOnClick() {
        if true /*game.getActive()*/ {
            /*game.toggleActive()*/
            gameOverUI(winner: 0) /*gameOverUI(winner: EMPTY_VAL)*/
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

}

