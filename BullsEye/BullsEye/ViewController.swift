//
//  ViewController.swift
//  BullsEye
//
//  Created by Maksim Gaiduk on 30/06/2022.
//

import UIKit

class ViewController: UIViewController {
    var sliderValue: Int = 0
    var currentGoal: Int = 0
    var round: Int = 0
    @IBOutlet var slider: UISlider!
    @IBOutlet var goalLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!

    override func viewDidLoad() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHightlighted = UIImage(named: "SliderThumb-Highlighted")!
        
        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)

        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        slider.setThumbImage(thumbImageHightlighted, for: .highlighted)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sliderValue = Int(slider.value)
        currentGoal = Int.random(in: 0...100)
        goalLabel.text = "\(currentGoal)"
        updateRoundLabel()
    }
    
    @IBAction func startOver() {
        currentGoal = Int.random(in: 0...100)
        goalLabel.text = "\(currentGoal)"
        slider.value = 50
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    func updateRoundLabel() {
        roundLabel.text = "\(round)"
    }

    @IBAction func showAlert() {
        let alert = UIAlertController(
            title: "Hello, World",
            message: "Slider value is: \(sliderValue)\nTarget value is: \(currentGoal)",
            preferredStyle: .alert)

        let action = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: {_ in
                self.currentGoal = Int.random(in: 0...100)
                self.goalLabel.text = "\(self.currentGoal)"
                self.round += 1
                self.updateRoundLabel()
            })

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("The value of the slider is now: \(slider.value)")
        sliderValue = Int(slider.value)
    }
}

