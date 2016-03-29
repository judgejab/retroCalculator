//
//  ViewController.swift
//  retroCalculator
//
//  Created by Anjali radhakrishnan on 3/23/16.
//  Copyright © 2016 Matt Cleary. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
       
    }
    
    @IBOutlet weak var outPutLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outPutLbl.text = runningNumber
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processedOperation(currentOperation)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processedOperation(Operation.Add)
    }
    
    @IBAction func onSubstractPressed(sender: AnyObject) {
        processedOperation(Operation.Subtract)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processedOperation(Operation.Multiply)
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processedOperation(Operation.Divide)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        
        playSound()
       
        runningNumber = ""
        
        leftValStr = ""
        
        rightValStr = ""
        
        result = ""
    
        outPutLbl.text = "0.0"
        
        currentOperation = Operation.Empty
    }
    

    
    
    func processedOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            // Run some math
            
            // A user selected an operator, but then selected another operatior
            // first entering a number
            
            if runningNumber != "" {
            rightValStr = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            } else if currentOperation == Operation.Empty {
                result = "0"
                }
            
            leftValStr = result
            outPutLbl.text = result
            }
            currentOperation = op
            
        } else {
            // This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

