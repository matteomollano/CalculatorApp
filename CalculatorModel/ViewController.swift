//
//  ViewController.swift
//  CalculatorModel
//
//  Created by Matteo Mollano on 4/11/22.
//

import UIKit

class ViewController: UIViewController {

    var Calculator: CalcBrain = CalcBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var lblExpression: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    
    @IBAction func btnClear(_ sender: UIButton) {
        Calculator.clear(expression: &lblExpression.text!, answer: &lblAnswer.text!)
    }
    
    @IBAction func negativePositiveBtn(_ sender: UIButton) {
        let main = self
        Calculator.negate(expression: &lblExpression.text!, controller: main)
    }
    
    @IBAction func btnNumberClick(_ sender: UIButton) {
        guard let userinput = sender.titleLabel?.text else{
            return
        }
        
        Calculator.numbers(expression: &lblExpression.text!, number: userinput)
    }
    
    @IBAction func btnOperators(_ sender: UIButton) {
        guard let userinput = sender.titleLabel?.text else{
            return
        }
        
        Calculator.operators(expression: &lblExpression.text!, mathOperator: userinput)
    }
    
    @IBAction func btnEqual(_ sender: UIButton) {
        let main = self
        Calculator.equals(expressionLabel: &lblExpression.text!, answerLabel: &lblAnswer.text!, controller: main)
    }
}

