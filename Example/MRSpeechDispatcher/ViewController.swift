//
//  ViewController.swift
//  MRSpeechDispatcher
//
//  Created by NA on 01/09/15.
//  Copyright (c) 2015 hectr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var remainingLabel: UILabel?
    
    let dispatcher = MRSpeechDispatcher()
    
    func updateLabelText() {
        dispatch_async(dispatch_get_main_queue(), {
            let count = self.dispatcher.queue!.operationCount
            self.remainingLabel!.text = "Remaining operations: \(count)"
        });
    }
    
    @IBAction func speakRegularAction(sender: UIButton) {
        let operation = dispatcher.speechText(
            sender.titleForState(UIControlState.Normal)!,
            withAnimus:MRSpeechAnimus.Regular
        )
        operation.completionBlock = {
            self.updateLabelText()
        }
        updateLabelText()
    }
    
    @IBAction func speakGladAction(sender: UIButton) {
        let operation = dispatcher.speechText(
            sender.titleForState(UIControlState.Normal)!,
            withAnimus:MRSpeechAnimus.Glad
        )
        operation.completionBlock = {
            self.updateLabelText()
        }
        updateLabelText()
    }
    
    @IBAction func speakFastAction(sender: UIButton) {
        let operation = dispatcher.speechText(
            sender.titleForState(UIControlState.Normal)!,
            withAnimus:MRSpeechAnimus.Hurry
        )
        operation.completionBlock = {
            self.updateLabelText()
        }
        updateLabelText()
    }

    @IBAction func speakDefaultAction(sender: UIButton) {
        let operation = dispatcher.speechText(
            sender.titleForState(UIControlState.Normal)!,
            withAnimus:MRSpeechAnimus.Default
        )
        operation.completionBlock = {
            self.updateLabelText()
        }
        updateLabelText()
    }
    
}
