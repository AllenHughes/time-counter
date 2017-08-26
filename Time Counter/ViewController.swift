//
//  ViewController.swift
//  Time Counter
//
//  Created by Allen Hughes on 8/24/17.
//  Copyright © 2017 i57e. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLable: UILabel!
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    

    var seconds = 60
    var count = 0
    var timer = Timer()
    var isTimerRunning = false
    var isTimerPaused = false

    @IBAction func countButtonTapped(_ sender: UIButton) {
        if self.isTimerRunning == true {
            self.count += 1
            countButton.setTitle("\(count)", for: .normal)
        }
    }
    @IBAction func timerPausedButtonTapped(_ sender: UIButton) {
        if self.isTimerPaused == false {
            timer.invalidate()
            
            self.isTimerPaused = true
            self.isTimerRunning = false
            
            self.countButton.isEnabled = false
            
            self.pauseButton.isHidden = true
            self.pauseButton.isEnabled = false
            
            self.startButton.isHidden = false
            self.startButton.isEnabled = true
            
            self.resetButton.isHidden = false
            self.resetButton.isEnabled = true
        }
    }
    
    @IBAction func timerStartButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            
            self.pauseButton.isHidden = false
            self.pauseButton.isEnabled = true
            
            self.startButton.isHidden = true
            self.startButton.isEnabled = false
            
            self.resetButton.isHidden = true
            self.resetButton.isEnabled = false
            
            self.countButton.isEnabled = true
            self.countButton.setTitle("\(count)", for: .normal)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            self.seconds = 60
            self.count = 0
            
            self.timerLable.text = "00:00:00"
            
            self.countButton.setTitle("Count", for: .normal)
            self.countButton.isEnabled = false
            
            self.resetButton.isEnabled = false
        }
    }
    
    func timerString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func updateTimer() {
        if seconds > 0 {
            // Call every second
            seconds -= 1
            timerLable.text = timerString(time: TimeInterval(self.seconds))
            
        } else {
            // Call when countdown hits zero
            timer.invalidate()
            
            self.seconds = 60
            self.count = 0
            
            self.isTimerRunning = false
            self.isTimerPaused = false
            
            self.countButton.isEnabled = false
            
            self.pauseButton.isHidden = true
            self.pauseButton.isEnabled = false
            
            self.startButton.isHidden = false
            self.startButton.isEnabled = true
            
            self.resetButton.isHidden = false
            self.resetButton.isEnabled = true
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)),
                                     userInfo:nil, repeats: true)
        self.isTimerRunning = true
        self.isTimerPaused = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countButton.setTitle("Count", for: .normal) // sets the text for countButton for startup
        countButton.isEnabled = false
        pauseButton.isHidden = true
        resetButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

}

