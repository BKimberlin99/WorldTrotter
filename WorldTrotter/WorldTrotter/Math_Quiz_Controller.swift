//
//  ViewController.swift
//  Math Quiz
//
//  Created by Brandon Kimberlin and Brandon Tate on 2/18/19.
//  Copyright © 2019 Brandon Kimberlin / Brandon Tate. All rights reserved.
//

import UIKit


class Math_Quiz_ViewController: UIViewController {

    @IBOutlet var firstNumber: UILabel!
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var secondNumber: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var questionNumLabel: UILabel!
    @IBOutlet var specialMessageLabel: UILabel!
    
    @IBOutlet var textField: UITextField!
    
    let firstNums: [Double] = [3.0, 2.0, 10.0, 6.0, 8.0, 12.0, 6.0, 9.0, 11.0, 15.0]
    
    let symbols: [String] = ["+", "-", "*", "/", "+", "+", "*", "/", "-", "-"]
    
    let secondNums: [Double] = [2.0, 2.0, 5.0, 3.0, 8.0, 7.0, 4.0, 3.0, 10.0, 9.0]
    
    let answers: [Double] = [5.0, 0.0, 50.0, 2.0, 16.0, 19.0, 24.0, 3.0, 1.0, 6.0]
    
    var currentQuestionIndex: Int = 1
    
    var score: Int = 0
    
    var scoreInfo: String = "Score: 0/0"
    
    var wasChecked = false //Variable to check if check answer was clicked before next question
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        questionNumLabel.text = "Question #1"
        messageLabel.text = ""
        scoreLabel.text = scoreInfo
        specialMessageLabel.text = ""
        
        firstNumber.text = String(firstNums[currentQuestionIndex - 1])
        symbolLabel.text = symbols[currentQuestionIndex - 1]
        secondNumber.text = String(secondNums[currentQuestionIndex - 1])
        
    }
    
    @IBAction func Check_Answer(_ sender: UIButton)
    {
        wasChecked = true
        
        if let userAnswer = textField.text, let value = Double(userAnswer) {
            if value == answers[currentQuestionIndex - 1] {
                score += 1
                updateScore()
                currentQuestionIndex += 1
                messageLabel.text = "Correct!"
            }
            else {
                messageLabel.text = "Incorrect - answer is " + String(answers[currentQuestionIndex - 1])
                updateScore()
                currentQuestionIndex += 1
                
            }
        } else {
            messageLabel.text = "Please enter an answer before pressing check answer"
        }
    }
    
    func updateScore()
    {
        scoreInfo = "Score: " + String(score) + "/" + String(currentQuestionIndex)
        scoreLabel.text = scoreInfo
    }
    
    @IBAction func nextQuestion(_ sender: UIButton)
    {
        if wasChecked == true
        {
            if currentQuestionIndex != 10
            {
                let firstNum: Double = firstNums[currentQuestionIndex - 1]
                let symbol: String = symbols[currentQuestionIndex - 1]
                let secondNum: Double = secondNums[currentQuestionIndex - 1]
            
                firstNumber.text = String(firstNum)
                symbolLabel.text = String(symbol)
                secondNumber.text = String(secondNum)
            
                //Empty user input box and correctness message
                textField.text = ""
                messageLabel.text = ""
                wasChecked = false
            
                questionNumLabel.text = "Question #" + String(currentQuestionIndex)
            }
        } else {
            messageLabel.text = "Please check answer before clicking next question"
        }
    }
    
    @IBAction func restart(_ sender: UIButton)
    {
        wasChecked = false
        currentQuestionIndex = 1
        score = 0
        
        updateScore()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //Set up variables for various illegal character cases
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        let replacementTextHasLetter = string.rangeOfCharacter(from: NSCharacterSet.letters)
        let replacementTextHasWhiteSpace = string.rangeOfCharacter(from: NSCharacterSet.whitespacesAndNewlines)
        let replacementTextHasSymbols = string.rangeOfCharacter(from: NSCharacterSet.symbols)
        let replacementTextHasPunctuation = string.rangeOfCharacter(from: NSCharacterSet.punctuationCharacters)
        let currentCharacterCount = textField.text?.count ?? 0
        
        //Check what is being entered and if it is anything other than 0-9, the first period/decimal, or a delete, nothing happens in the app
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        } else if replacementTextHasLetter != nil {
            return false
        } else if replacementTextHasWhiteSpace != nil {
            return false
        } else if replacementTextHasSymbols != nil {
            return false
        } else if replacementTextHasPunctuation != nil, replacementTextHasDecimalSeparator == nil {
            return false
        } else if range.length + range.location > currentCharacterCount {
            return false
        } else {
            let newLength = currentCharacterCount + string.count - range.length
            return newLength <= 3
        }
        
    }
}

