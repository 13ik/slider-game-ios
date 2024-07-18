//
//  ViewController.swift
//  SliderGame
//
//  Created by Ihor Korolov on 06/07/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    
    var targetValue = 0
    var score = 0
    var round = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImageNormal = UIImage(named: "6")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImagePressed = UIImage(named: "5")
        slider.setThumbImage(thumbImagePressed, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "7")
        let resizableLeft = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(resizableLeft, for: .normal)
        
        let trackRightImage = UIImage(named: "8")
        let resizableRight = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(resizableRight, for: .normal)
        
        newRound()
    }
    
    func newRound(){
        targetValue =  Int.random(in: 1...100)
        targetLabel.text = "\(targetValue)"
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
        slider.value = 50
        
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
        view.layer.add(transition, forKey: nil)
        
    }
    
    
    
    @IBAction func restart() {
        score = 0
        round = 1
        newRound()
    }
    
    @IBAction func showAlert() {
        
        let currentValue = lroundf(slider.value)
        let diffrence = abs(currentValue - targetValue)
        var currentScore = 100 - diffrence
        
        let title: String
        
        if diffrence == 0 {
            title = "Perfect!"
            currentScore += 100
        } else if diffrence < 5 {
            title = "Good!"
            if diffrence < 3 {
                currentScore += 50
            }
        } else if diffrence < 10 {
            title = "Not bad!"
        } else {
            title = "Loser :^("
        }
        
        let message = "You get: \(currentValue) scores"
        
        let alertWindow = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.newRound()
        })
        
        alertWindow.addAction(action)
        present(alertWindow, animated: true)
        
        score += currentScore
        round += 1
    }
}
