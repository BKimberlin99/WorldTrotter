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

    
    let symbols: [String] = ["+", "-", "*", "/"]
    
    
    var currentQuestionIndex: Int = 1
    
    var score: Int = 0
    
    var answer: Double = 0

    var answerStr: String = "" //Variable to hold string version of answer for formatting
    
    var scoreInfo: String = "Score: 0/0"
    
    var wasChecked = false //Variable to check if check answer was clicked before next question
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up what happens on start of Math Quiz
        
        questionNumLabel.text = "Question #1"
        messageLabel.text = ""
        scoreLabel.text = scoreInfo
        specialMessageLabel.text = ""
        
        let firstNum = arc4random_uniform(21) - 10
        //only allow numbers 1-30 to avoid division by 0
        let secondNum = arc4random_uniform(21) - 10
        //grab a random operator in symbol array
        let symbol = symbols[Int(arc4random_uniform(4))]
        
        firstNumber.text = String(firstNum)
        symbolLabel.text = String(symbol)
        secondNumber.text = String(secondNum)
        
        answer = doMath(Double(firstNum), Double(secondNum), symbol)
        answerStr = String(format: "%.2f", answer) //Create a string with the answer to format
    }
    
    
    
    
    
    
    @IBAction func Check_Answer(_ sender: UIButton)
    {
        if let userAnswer = textField.text, let value = Double(userAnswer) {
            if value == Double(answerStr) {
                score += 1
                updateScore()
                currentQuestionIndex += 1
                messageLabel.text = "Correct!"
            }
            else {
                messageLabel.text = "Incorrect - answer is " + String(answer)
                updateScore()
                currentQuestionIndex += 1
                
            }
        } else {
            messageLabel.text = "Please enter an answer \nbefore pressing check answer"
        }
        // Flag that tells that the user has checked their answer
        wasChecked = true
    }
    
    func updateScore()
    {
        // Updates score depending on if the user got the question right or not
        scoreInfo = "Score: " + String(score) + "/" + String(currentQuestionIndex)
        scoreLabel.text = scoreInfo
    }
    
    @IBAction func nextQuestion(_ sender: UIButton)
    {
        // Moves on to next question if answer has been checked
        if wasChecked == true
        {
            if currentQuestionIndex != 11
            {
                
                let firstNum = arc4random_uniform(21) - 10
                //only allow numbers 1-30 to avoid division by 0
                let secondNum = arc4random_uniform(21) - 10
                //grab a random operator in symbol array
                let symbol = symbols[Int(arc4random_uniform(4))]
                
                firstNumber.text = String(firstNum)
                symbolLabel.text = String(symbol)
                secondNumber.text = String(secondNum)
            
                answer = doMath(Double(firstNum), Double(secondNum), symbol)
                answerStr = String(format: "%.2f", answer)
                
                
                //Empty user input box and correctness message
                textField.text = ""
                messageLabel.text = ""
                wasChecked = false
            
                questionNumLabel.text = "Question #" + String(currentQuestionIndex)
            } else{
                switch(score){
                    case 0..<7:
                        messageLabel.text = "Better luck next time!"
                    case 7:
                        messageLabel.text = "70% - Good work!"
                    case 8:
                        messageLabel.text = "80% - Great work!"
                    case 9:
                        messageLabel.text = "90% - Excellent!"
                    case 10:
                        messageLabel.text = "100% - Perfect!"
                    default:
                        //to get rid of xcode error saying switch must be exhaustive
                        messageLabel.text = "error"
                }
                
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
        
        let firstNum = arc4random_uniform(21) - 10
        let secondNum = arc4random_uniform(21) - 10
        //grab a random operator in symbol array
        let symbol = symbols[Int(arc4random_uniform(4))]
        
        firstNumber.text = String(firstNum)
        symbolLabel.text = String(symbol)
        secondNumber.text = String(secondNum)
        
        answer = doMath(Double(firstNum), Double(secondNum), symbol)
        
        messageLabel.text = ""
        scoreLabel.text = "Score: 0/0"
        questionNumLabel.text = "Question #1"
        specialMessageLabel.text = ""
        
        textField.text = ""
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



//functions to do math operations
func add(_ a: Double, _ b: Double)->Double
{
    return a+b
}

func sub(_ a: Double, _ b: Double)->Double
{
    return a-b
}

func div(_ a: Double, _ b: Double)->Double
{
    if b != 0{
        return a/b
    }
    else{
        return 1
    }
}

func mult(_ a: Double, _ b: Double)->Double
{
    return a*b
}

//Define a typealias for the prototype of the simple math functions
typealias binOp = (Double, Double)->Double

//Associates the Op values with one of the simple math functions
let ops: [String: binOp]=["+":add, "-":sub, "*":mult, "/":div]


//second version of doMath to return value of specified operation
func doMath(_ a: Double, _ b: Double, _ op: String)->Double
{
    let opFunc=ops["\(op)"]
    return opFunc!(a,b)
}

