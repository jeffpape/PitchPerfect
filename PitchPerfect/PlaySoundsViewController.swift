//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Jeffrey Pape on 15-9-27.
//  Copyright © 2015 Jeffrey Pape. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
            audioPlayer.enableRate = true
        } catch {
            print("Audio Play is not available!")
        }
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playAudo(playRate: Float) {
        stopAudioPlayerAndAudioEngine()
        audioPlayer!.rate = playRate
        audioPlayer?.currentTime = 0.0
        audioPlayer?.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudo(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudo(1.5)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAudioPlayerAndAudioEngine()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAudioPlayerAndAudioEngine()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
    }
    
    func stopAudioPlayerAndAudioEngine() {
        audioPlayer!.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playChipMunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        // reverb icon from Reactable mobile Manual www.reactable.com
        stopAudioPlayerAndAudioEngine()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        let audioUnitReverb = AVAudioUnitReverb()
        audioUnitReverb.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        audioUnitReverb.wetDryMix = 50
        audioEngine.attachNode(audioUnitReverb)
        
        audioEngine.connect(audioPlayerNode, to: audioUnitReverb, format: nil)
        audioEngine.connect(audioUnitReverb, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
    }
    
    @IBAction func playEchoAudio(sender: UIButton) {
        // distortion icon from Calf Studio Gear - GNU/Linux Audio Plug-Ins
        stopAudioPlayerAndAudioEngine()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let audioUnitDistortion = AVAudioUnitDistortion()
        audioUnitDistortion.loadFactoryPreset(AVAudioUnitDistortionPreset.DrumsBitBrush)
        audioUnitDistortion.preGain = -6
        audioUnitDistortion.wetDryMix = 50
        audioEngine.attachNode(audioUnitDistortion)
        
        audioEngine.connect(audioPlayerNode, to: audioUnitDistortion, format: nil)
        audioEngine.connect(audioUnitDistortion, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
    }
    
}
