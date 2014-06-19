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
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }
    
    @IBAction func addOperand(aBtn : UIButton){
        let newOp : String = "\(aBtn.tag)"
        self.calculator.appendOperand(newOp)
        
        let outputStr : String = self.calculator.stringOfInput
        digitalLabel.text = outputStr
    }
    
    @IBAction func setPlusOperator(sender : UIButton){
        self.calculator.makeOperator("+")
        digitalLabel.text = "0"
    }
    
    @IBAction func setMinusOperator(sender : UIButton){
        self.calculator.makeOperator("-")
        digitalLabel.text = "0"
    }
    
    @IBAction func setDivideOperator(sender : UIButton){
        self.calculator.makeOperator("/")
        digitalLabel.text = "0"
    }
    
    @IBAction func setMulitplyOperator(sender : UIButton){
        self.calculator.makeOperator("*")
        digitalLabel.text = "0"
    }
    
    @IBAction func makeOperation(sender : UIButton){
        self.calculator.perfomOperation()
        digitalLabel.text = self.calculator.stringOfCurrentSum()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        digitalLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

