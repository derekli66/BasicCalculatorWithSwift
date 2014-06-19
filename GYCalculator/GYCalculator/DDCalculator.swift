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
   
    let overFlowString = "999999999"
    let maximumLength = 10
    var sumOfInput : Double = 0
    var stringOfSum : String = ""
    var stringOfInput : String = ""
    var operator : String = ""
    
    func currentSum() -> Double{
        return stringOfSum.bridgeToObjectiveC().doubleValue
    }
    
    func stringOfCurrentSum() -> String{
        return stringOfSum
    }
    
    func appendOperand(operand : String){
        if countElements(stringOfInput) < maximumLength {
            let isADot : Bool = (operand == ".")
            let didContain : Bool = stringOfInput.bridgeToObjectiveC().containsString(".")
            if !(isADot && didContain) {
                stringOfInput += operand
            }
        }
    }
    
    func optimizeSum(){
        //check Zero at end of Sum
        let elementCount = countElements(stringOfSum)
        var modifiedSumString : String = ""
        
        var i = elementCount - 1
        while i > 0 {
            let singleStr = stringOfSum[i]
            if singleStr != "0" {
                stringOfSum = stringOfSum.bridgeToObjectiveC().substringToIndex( i + 1)
                break
            }
            
            i -= 1
        }
        
        //check last Dot
        if countElements(stringOfSum) > 0 {
            let lastStr = stringOfSum[(countElements(stringOfSum) - 1)]
            if lastStr == "." {
                stringOfSum = stringOfSum.bridgeToObjectiveC().substringToIndex((countElements(stringOfSum) - 1))
            }
        }
        
        //check maximum length of stringOfSum
        if countElements(stringOfSum) > maximumLength {
            stringOfSum = overFlowString
        }
    }
    
    func makeOperator(anOperator : String){
        let operatorChecker = ["+", "-", "*", "/"]
        if operatorChecker.bridgeToObjectiveC().containsObject(anOperator) {
            if operator != ""  {
                // with existing sum and operator, perform operation
                self.perfomOperation()
            }
            else{
                stringOfSum = stringOfInput
                self.optimizeSum()
                stringOfInput = ""
                sumOfInput = stringOfSum.bridgeToObjectiveC().doubleValue
            }
            
            operator = anOperator
        }
    }
    
    func perfomOperation(){
        
        let currentSum : Double = stringOfSum.bridgeToObjectiveC().doubleValue
        let currentInput : Double = stringOfInput.bridgeToObjectiveC().doubleValue
        
        if operator == "+" {
            sumOfInput = currentSum + currentInput
        }
        else if operator == "-" {
            sumOfInput = currentSum - currentInput
        }
        else if operator == "*" {
            sumOfInput = currentSum * currentInput
        }
        else if operator == "/" {
            if currentInput == 0 {
                sumOfInput = overFlowString.bridgeToObjectiveC().doubleValue
            }
            else {
                sumOfInput = currentSum / currentInput
            }
        }
        
        stringOfSum = "\(sumOfInput)"
        self.optimizeSum()
        operator = ""
        stringOfInput = ""
        sumOfInput = 0
    }
    
    func restCalculator(){
        sumOfInput = 0
        stringOfInput = ""
        stringOfSum = ""
        operator = ""
    }
}
