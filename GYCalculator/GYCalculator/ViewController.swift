//
//  ViewController.swift
//  GYCalculator
//
//  Created by LEE CHIEN-MING on 6/18/14.
//  Copyright (c) 2014 Derek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button01 : UIButton
    @IBOutlet var button02 : UIButton
    @IBOutlet var button03 : UIButton
    @IBOutlet var button04 : UIButton
    @IBOutlet var button05 : UIButton
    @IBOutlet var button06 : UIButton
    @IBOutlet var button07 : UIButton
    @IBOutlet var button08 : UIButton
    @IBOutlet var button09 : UIButton

    @IBOutlet var buttonZero : UIButton
    @IBOutlet var buttonDot : UIButton
    @IBOutlet var buttonPlus : UIButton
    @IBOutlet var buttonMinus : UIButton
    @IBOutlet var buttonMultiply  : UIButton
    @IBOutlet var buttonDivide  : UIButton
    @IBOutlet var buttonClean : UIButton
    @IBOutlet var buttonOperation : UIButton
    @IBOutlet var digitalLabel : UILabel
    
    var calculator : DDCalculator = DDCalculator()
    var lastOperator : String = ""
    var didEnter : Bool = false
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }
    
    @IBAction func addOperand(aBtn : UIButton){
        let newOp : String = "\(aBtn.tag)"
        calculator.appendInputOperand(newOp)
        
        let outputStr : String = calculator.inputString
        digitalLabel.text = outputStr
    }
    
    @IBAction func addDot(aBtn : UIButton){
        if didEnter == true {
            didEnter = false
            calculator.resetCalculator()
        }
        self.calculator.appendInputOperand(".")
    }
    
    @IBAction func pressOperatorButton(sender : UIButton){
        var anOperator : String = ""
        switch sender.tag {
        case 11 : anOperator = "+"
        case 12 : anOperator = "-"
        case 13 : anOperator = "*"
        case 14 : anOperator = "/"
        default : anOperator = ""
        }
        
        // if user has pressed enter, make current sum to be the first input
        if didEnter == true {
            didEnter = false
            let tempStr = calculator.sumString
            calculator.resetCalculator()
            calculator.sumString = tempStr
        }
        else{
            calculator.perfomOperation()
            calculator.inputString = ""
        }
        
        calculator.makeOperator(anOperator)
        digitalLabel.text = "0"
    }
    
    @IBAction func makeOperation(sender : UIButton){
        didEnter = true
        calculator.perfomOperation()
        digitalLabel.text = self.calculator.sumString
    }
    
    @IBAction func cleanNumbers(sender : UIButton){
        digitalLabel.text = "0"
        didEnter = false
        calculator.resetCalculator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        digitalLabel.text = "0"
    }
}

