//
//  ViewController.swift
//  BullsEye
//
//  Created by Stephen Bassett on 8/9/18.
//  Copyright © 2018 Stephen Bassett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentSliderValue = 0
    var targetValue = 0
    var currentRound = 1
    var currentScore = 0
    var score = 0
    static var scoreToBeat = UserDefaults.standard.integer(forKey: "scoreToBeat")
    static var numberOfRounds = UserDefaults.standard.integer(forKey: "numberOfRounds")

    @IBOutlet weak var pintGoalLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var setScoreLimitLabel: UILabel!
    @IBOutlet weak var setRoundLimitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(AboutViewController.pointsSegmentIndex, forKey: "scoreToBeatIndex")
        UserDefaults.standard.set(AboutViewController.roundsSegmentIndex, forKey: "numberOfRoundsIndex")
        UserDefaults.standard.set(AboutViewController.selectedPoints, forKey: "scoreToBeat")
        UserDefaults.standard.set(AboutViewController.selectedRounds, forKey: "numberOfRounds")
        UserDefaults.standard.synchronize()
        let roundedValue = slider.value.rounded()
        currentSliderValue = Int(roundedValue)
        newGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        newGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hitMeButtonTapped(_ sender: Any) {
        currentScore += scoreCalculation(sliderValue: currentSliderValue, targetValue: targetValue)
        if currentRound <= ViewController.numberOfRounds && currentScore <= ViewController.scoreToBeat {
            if currentRound == ViewController.numberOfRounds && currentScore <= ViewController.scoreToBeat {
                let title = "Congratulations"
                let message = "CONGRATULATIONS YOU WIN!!!" + "\nFinal score of \(currentScore)"
                let buttonTitle = "Start Over"
                alert(title: title, message: message, buttonTitle: buttonTitle, gameFinished: true)
            } else {
                let title: String
                let bonus: String
                let scoreString: String
                if score == 0 {
                    title = "WOW Perfect!!"
                    scoreString = "\nYou scored \(score) points"
                    bonus = "\nYou get a bonus of 5 points removed from your score!"
                } else if score == 1 {
                    title = "Nearly Perfect!"
                    scoreString = "\nYou scored \(score) point"
                    bonus = "\nYou get a bonus of 2 points removed from your score!"
                }else if score < 5 {
                    title = "Pretty Good"
                    scoreString = "\nYou scored \(score) points"
                    bonus = ""
                } else if score < 10 {
                    title = "Not Bad..."
                    scoreString = "\nYou scored \(score) points"
                    bonus = ""
                } else {
                    title = "SMH... Not Even Close..."
                    scoreString = "\nYou scored \(score) points"
                    bonus = ""
                }
                let message = "The target point was: \(targetValue)" + "\nYou guessed \(currentSliderValue)" + scoreString + bonus
                let buttonTitle = "OK"
                alert(title: title, message: message, buttonTitle: buttonTitle, gameFinished: false)
            }
        } else {
            let round: String
            if currentRound == 1 {
                round = "\nin \(currentRound) round"
            } else {
                round = "\nin \(currentRound) rounds"
            }
            
            let title = "Too Bad So Sad..."
            let message = "WOW you reached a score of \(currentScore)" + round + "\nYou are quite TERRIBLE at this!!!"
            let buttonTitle = "Start Over"
            alert(title: title, message: message, buttonTitle: buttonTitle, gameFinished: true)
        }
    }
    
    @IBAction func pointsSlider(_ sender: UISlider) {
        let roundedValue = sender.value.rounded()
        currentSliderValue = Int(roundedValue)
    }
    
    @IBAction func startOverButtonTapped(_ sender: Any) {
        newGame()
    }
    
    @IBAction func InfoButtonTapped(_ sender: Any) {
        AboutViewController.pointsSegmentIndex = Int(setScoreLimitLabel.text ?? "") ?? 0
        AboutViewController.roundsSegmentIndex = Int(setRoundLimitLabel.text ?? "") ?? 0
    }
    
    func startNewRound() {
        currentRound += 1
        updateLabels()
    }
    
    func updateLabels() {
        targetValue = Int.random(in: 1...100)
        currentSliderValue = 50
        slider.value = Float(currentSliderValue)
        scoreLabel.text = String(currentScore)
        pintGoalLabel.text = String(targetValue)
        roundLabel.text = String(currentRound)
    }
    
    func scoreCalculation(sliderValue: Int, targetValue: Int) -> Int{
        score = abs(sliderValue - targetValue)
        if score == 0 {
            currentScore -= 5
        } else if score == 1 {
            currentScore -= 3
        }
        return score
    }
    
    final func newGame() {
        currentScore = 0
        currentRound = 1
        setRoundLimitLabel.text = String(UserDefaults.standard.integer(forKey: "numberOfRounds"))
        setScoreLimitLabel.text = String(UserDefaults.standard.integer(forKey: "scoreToBeat"))
        updateLabels()
    }
    
    func alert(title: String, message: String, buttonTitle: String, gameFinished: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: {
            action in
            if gameFinished {
                self.newGame()
            } else {
                self.startNewRound()
            }
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

