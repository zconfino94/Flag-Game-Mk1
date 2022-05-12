//
//  ViewController.swift
//  Project 2
//
//  Created by Zachary Confino on 10/9/19.
//  Copyright © 2019 Zachary Confino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    //Brings storyboard layouts into the code environment so you can manipulate it
    @IBOutlet var scoreButton: UIBarButtonItem!
    @IBOutlet var refreshButton: UIBarButtonItem!
    
    var countries = [String]()
    //This creates an empty array, which is to be filled with String data
    var score = 0
    //Score vairable to be filled with Integer data
    var correctAnswer = 0
    var questionsAnsweredCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        //This adds to the empty array "countries" with the following country names.
        //Using the operator += means it adds the values to the array, and then becomes the array itself.
    
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        //This creates the button border, and the number dictates the width of the boarder.
        //The value "1" is 1 point, rather than 1 pixel. This is because of the difference between pixel densities on iOS devices. By using a point reference model, iOS can then covert this so it looks the same on a non-retina display, a retina display and a retina HD display.
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        //This changes the border colour from default black to light gray.
        //You can create a customer colour, by using the following: button1.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        //Ensure you add .cgColour to ensure that the colour is converted to cg (Core Graphics), rather than leaving as a UI Colour
        //This is required as UI and CG are different layers, so you have to convert between the layers.
        
        askQuestion(action: nil)
    }
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        //This reorders the array of Countries, so that the next lines of code just presents the top three in the array, once shuffled.
        //This is simpler than keeping the array the same and changing the numbers to be called, becuase there's no risk of returning the same flag twice, and if you add more images to the array, you don't have to change the code.
        correctAnswer = Int.random(in: 0...2)
        //This allows Swift to choose a random number between 0 and 2 (inclusive) by using a closed range operator (...). Once completed, this value then is returned into the variable "correctAnswer".
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        //This allows the UI element (image) to present value depending on the title of the image.
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = ("\(countries[correctAnswer].uppercased())")
        //This creates the title of the page, with the name of the correct answer by the following:
        //a) selecting the countries array
        //b) stating that the random number created by Int.random(in: 0...2) is the correct answer
        //c) the text is then capitalised by the .uppercased() function
    }
    
    @IBAction func scoreButton(_ sender: UIBarButtonItem) {
          let scoreTitle = ("Your current score is \(score)")
          
          let cs = UIAlertController(title: scoreTitle, message: "Continue playing for a higher score", preferredStyle: .alert)
          cs.addAction(UIAlertAction(title: "Dismiss", style: .default))
          present(cs, animated: true)
          }
    //This allows the user to check their current score using an alert by pressing the share button
      
      @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
          let answerHint = correctAnswer+1
          let ca = UIAlertController(title: "Correct answer is \(answerHint)", message: "Don't use too many hints", preferredStyle: .alert)
          ca.addAction(UIAlertAction(title: "Continue", style: .default))
          present(ca, animated: true)
      }
    //This allows for the user to see the correct answer by pressing the refresh button
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        //Allows storyboard elements to trigger code
        //All three buttons are part of the same Action code, so it's important we know which button has been pressed.
        var title: String
        var message: String
        //Creates the variable for the title, but it is currently empty
        if sender.tag == correctAnswer {
            //We changed the tag value (in storyboard) for the three buttons to correspond with the value of "correctAnswer", so this is how we can create the conditional if statment.
            score += 1
            questionsAnsweredCounter += 1
            title = "Correct"
            message = "You gain a point. Your score is \(score)"
        }
        else {
            score -= 1
            questionsAnsweredCounter += 1
            title = "Incorrect, that's the flag of \(countries[sender.tag].uppercased())"
            message = "You lose a point. Your score is \(score)"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Next", style: .default, handler: askQuestion))
        present(ac, animated: true)
        }
    }
