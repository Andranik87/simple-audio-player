//
//  ViewController.swift
//  Audio Player
//
//  Created by Andranik Karapetyan on 4/21/20.
//  Copyright © 2020 Andranik Karapetyan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var progressBar: UISlider!
    
    var player = AVAudioPlayer()
    var timer = Timer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let audioPath = Bundle.main.path(forResource: "MidnightRider", ofType: "mp3")
        
        do
        {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            progressBar.maximumValue = Float(player.duration)
        }
        catch
        {
            // Process errors
        }
        
        progressBar.value = 0
        player.volume = slider.value
    }

    @objc func updateProgressBar()
    {
        progressBar.value = Float(player.currentTime) //Float(percentToValue(percent: playTimeToPercent(), value: 1))
    }
    
    @IBAction func Play(_ sender: Any)
    {
        player.play()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.updateProgressBar), userInfo: nil, repeats: true)
    }
    @IBAction func Pause(_ sender: Any)
    {
        player.pause()
        
        timer.invalidate()
    }
    @IBAction func Stop(_ sender: Any)
    {
        timer.invalidate()
        player.pause()
        player.currentTime = 0
        progressBar.value = 0
    }
    @IBAction func SliderMoved(_ sender: Any)
    {
        player.volume = slider.value
    }
    @IBAction func PorgressSliderMoved(_ sender: Any)
    {
        player.pause()
        player.currentTime = Double(progressBar.value) //percentToValue(percent: sliderValueToPercent(), value: player.duration)
        player.play()
    }
    
    func playTimeToPercent() -> Double
    {
        return player.currentTime * 100.0 / player.duration
    }
    
    func sliderValueToPercent() -> Double
    {
        return Double(progressBar.value) * 100.0
    }
    
    func percentToValue(percent: Double, value: Double) -> Double
    {
        return value * (percent / 100)
    }
}

