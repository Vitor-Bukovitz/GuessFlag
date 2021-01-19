//
//  ViewController.swift
//  GuessFlag
//
//  Created by Vitor Bukovitz on 18/01/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "\(countries[correctAnswer].uppercased())\nYour Score: \(score)"
        self.navigationItem.titleView = label
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That is the flag of \(countries[sender.tag].capitalized)!"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        var actionTitle = "Continue"
        if questionsAnswered >= 10 {
            ac.message = "Game over! Your final score is \(score)"
            actionTitle = "Restart Game"
            questionsAnswered = 0
            score = 0
        } else {
            questionsAnswered += 1
        }
        ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
}

