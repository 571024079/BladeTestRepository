//
//  ViewController.swift
//  InterfaceBuilder
//
//  Created by Handlecar on 16/5/20.
//  Copyright © 2016年 NerdRanchGuide. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var questionLabel : UILabel!
    @IBOutlet var answerLabel : UILabel!
    
    @IBAction func showNextQuestion(sender: AnyObject){
        currentQuestionIndex++
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0;
        }
        
        let question: String = questions[currentQuestionIndex]
        questionLabel.text = question
        answerLabel.text = "????"
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    let questions: [String] = ["From what is cognac made?",
                               "what is 7 + 7?",
                               "what is the capital of vermont?"]
    let answers: [String] = ["Grapes",
                            "14",
                            "Montpelier"]
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}



