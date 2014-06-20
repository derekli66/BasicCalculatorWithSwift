//
//  StringModifier.swift
//  SomeHow
//
//  Created by LEE CHIEN-MING on 6/14/14.
//  Copyright (c) 2014 Derek. All rights reserved.
//

import UIKit

//extension to get single character string with index
extension String{
    subscript (i: Int) -> String {
        return String(Array(self)[i])
    }
}

class DDCalculator: NSObject {
   
    var sumString : String = ""
    var inputString : String = ""
    var operator : String = ""
    
    let overFlowString = "999999999"
    let maximumLength = 10
    
    func currentSum() -> Double {
        return sumString.bridgeToObjectiveC().doubleValue
    }
    
    func appendInputOperand(operand : String) {
        if countElements(inputString) < maximumLength {
            let isADot : Bool = (operand == ".")
            let didContain : Bool = inputString.bridgeToObjectiveC().containsString(".")
            
            //if operand is a Dot and inputString contains a Dot, do nothing for this situation
            if !(isADot && didContain) {
                inputString += operand
            }
        }
    }
    
    func optimizeSum() {
        //check Zero at end of Sum
        let elementCount = countElements(sumString)
        var modifiedSumString : String = ""
        
        var i = elementCount - 1
        while i > 0 {
            let singleStr = sumString[i]
            if singleStr != "0" {
                sumString = sumString.bridgeToObjectiveC().substringToIndex( i + 1)
                break
            }
            
            i -= 1
        }
        
        //check last Dot
        if countElements(sumString) > 0 {
            let lastStr = sumString[(countElements(sumString) - 1)]
            if lastStr == "." {
                sumString = sumString.bridgeToObjectiveC().substringToIndex((countElements(sumString) - 1))
            }
        }
        
        //check maximum length of sumString
        if countElements(sumString) > maximumLength {
            sumString = overFlowString
        }
    }
    
    func makeOperator(anOperator : String) {
        //only allow mathematical operator goes in
        let operatorChecker = ["+", "-", "*", "/"]
        if operatorChecker.bridgeToObjectiveC().containsObject(anOperator) {
            operator = anOperator
        }
    }
    
    func perfomOperation() {
        
        let currentSum : Double = sumString.bridgeToObjectiveC().doubleValue
        let currentInput : Double = inputString.bridgeToObjectiveC().doubleValue
        var sumValue : Double = 0
        
        if operator == "+" {
            sumValue = currentSum + currentInput
        }
        else if operator == "-" {
            sumValue = currentSum - currentInput
        }
        else if operator == "*" {
            sumValue = currentSum * currentInput
        }
        else if operator == "/" {
            if currentInput == 0 {
                sumValue = overFlowString.bridgeToObjectiveC().doubleValue
            }
            else {
                sumValue = currentSum / currentInput
            }
        }
        else{
            sumValue = inputString.bridgeToObjectiveC().doubleValue
        }
        
        sumString = "\(sumValue)"
        self.optimizeSum()
    }
    
    func resetCalculator() {
        inputString = ""
        sumString = ""
        operator = ""
    }
}
