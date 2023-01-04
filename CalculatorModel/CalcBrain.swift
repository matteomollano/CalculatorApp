//
//  CalcBrain.swift
//  CalculatorModel
//
//  Created by Matteo Mollano on 4/12/22.
//

import Foundation
import UIKit

class CalcBrain {
    
    // clear button
    func clear (expression: inout String, answer: inout String) {
        expression = "0"
        answer = ""
    }
    
    // negative/positive button
    func negate (expression: inout String, controller: ViewController) {
        if validNegation(expressionString: &expression) {
            let int_conv: Double = Double(expression)!
            var int_num: Int = Int(int_conv)
            var double_num: Double = Double(expression)!
            
            if Double(int_num) == double_num {
                int_num = int_num * -1
                expression = String(int_num)
            }
            else {
                double_num = double_num * -1
                expression = String(double_num)
            }
        }
        
        else {
            let alert = UIAlertController(title: "Invalid Negation", message: "You cannot negate an expression that contains a math operator", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            controller.present(alert, animated: true, completion: nil)
        }
    }

    func validNegation(expressionString: inout String) -> Bool {
        let specialCharArray = ["%", "/", "*", "-", "+"]
        
        for char in specialCharArray {
            if expressionString.contains(char) && expressionString.first != "-" {
                return false
            }
        }
        
        return true
    }
    
    // number button
    func numbers (expression: inout String, number: String) {
        if !(expression.isEmpty) && expression.first == "0" {
            expression += number
            expression.removeFirst()
        }
        else {
            expression += number
        }
    }
    
    // operators button
    func operators (expression: inout String, mathOperator: String) {
        if mathOperator == "%" {
            expression += "%"
        }
        else if mathOperator == "/" {
            expression += "/"
        }
        else if mathOperator == "x" {
            expression += "*"
        }
        else if mathOperator == "-" {
            expression += "-"
        }
        else if mathOperator == "+" {
            expression += "+"
        }
    }
    
    // equals button
    func equals (expressionLabel: inout String, answerLabel: inout String, controller: ViewController) {
        if !(expressionLabel.contains(".")) && expressionLabel.last == "%" && validInput(expLabel: expressionLabel) {
            expressionLabel.removeLast()
            expressionLabel += ".0%"
        }
        
        else if validInput(expLabel: expressionLabel) {
            expressionLabel += ".0"
        }
        
        if (validInput(expLabel: expressionLabel)) {

            let expressionUpdated = expressionLabel.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: expressionUpdated)
            let answer = expression.expressionValue(with: nil, context: nil) as! Double
            let answerString = formatAnswer(answer: answer)
            answerLabel = answerString
            
            if expressionLabel.last == "%" {
                expressionLabel.removeLast()
                expressionLabel.removeLast()
                expressionLabel.removeLast()
                expressionLabel += "%"
            }
            
            else {
                expressionLabel.removeLast()
                expressionLabel.removeLast()
            }
        }
        
        else {
            let alert = UIAlertController(title: "Invalid Input", message: "You have entered invalid data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func validInput(expLabel: String) -> Bool {
        
        var count = 0
        var charIndicesArray = [Int]()
        
        for char in expLabel {
            if(specialCharacterChecker(char: char)){
                charIndicesArray.append(count)
            }
            count += 1
        }
        
        var previousChar: Int = -1
        
        for index in charIndicesArray {
            if (index == 0 && expLabel.first != "-") { // special character is in the first index of string
                return false
            }
            
            if (index == expLabel.count - 1 && expLabel.last != "%") { // special character is in the last index of string
                return false
            }
            
            if (previousChar != -1) {
                if (index - previousChar == 1) { // if there are two special characters in a row
                    return false
                }
            }
            previousChar = index
        }
        
        return true
    }
    
    func specialCharacterChecker (char: Character) -> Bool {
        if char == "%" {
            return true
        }
        
        if char == "/" {
            return true
        }
        
        if char == "*" {
            return true
        }
        
        if char == "-" {
            return true
        }
        
        if char == "+" {
            return true
        }
        
        if char == "." {
            return true
        }
        
        return false
    }
    
    func formatAnswer(answer: Double) -> String {
        
        let answerConvToInt = Int(answer)
        let intBackToDouble = Double(answerConvToInt)
        
        if intBackToDouble == answer {
            return String(answerConvToInt)
        }
        else {
            return String(answer)
        }
    }
}
