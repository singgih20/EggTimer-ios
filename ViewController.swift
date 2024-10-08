//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let eggTimes: [String:Int] = ["Soft": 1, "Medium": 7, "Hard": 12]
    var remainingTime = 60  // Mulai dari 60 detik
    var timer: Timer?
    var audioPlayer: AVAudioPlayer?

    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle
        switch hardness {
        case "Soft":
            startTimer(minutes: eggTimes["Soft"]!)
            
        case "Medium":
            startTimer(minutes: eggTimes["Medium"]!)
        case "Hard":
            startTimer(minutes: eggTimes["Hard"]!)
        default:
            print("default nih")
        }
    }
    
    func startTimer(minutes: Int) {
        timer?.invalidate()
        var remainingTime = minutes
        let totalTime = minutes 
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            if remainingTime > 0 {
                remainingTime -= 1
                self.progressView.progress = Float(totalTime - remainingTime) / Float(totalTime)
            } else {
                timer.invalidate()
                self.label.text = "Time out!"
                self.playSound()
            }
        })
    }
    
    func playSound() {
        // Path file audio
        if let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") {
            do {
                // Inisialisasi AVAudioPlayer dengan file audio
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()  // Memainkan suara
            } catch {
                print("Tidak dapat memutar suara. Error: \(error)")
            }
        }
    }

}
