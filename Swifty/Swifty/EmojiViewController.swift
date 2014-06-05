//
//  ExampleEmojiViewController.swift
//  Swifty
//
//  Created by AndrewTremblay on 6/4/14.
//  Copyright (c) 2014 andrewTremblayLLC. All rights reserved.
//

import UIKit

//extensions!
//these will either make your programming experience a walk in a park or a trudge through a quagmire
extension UIButton {
    func toggleSelected() {
        self.selected = !self.selected
    }
}

class EmojiViewController: UIViewController {
    @IBOutlet var buttonSolarLunarPhases : UIButton
    @IBOutlet var buttonRecycleIcon : UIButton
    @IBOutlet var buttonSound : UIButton
        
    //one thing you're gonna have to get used to is jokers like me doing this kind of stuff
    func 😋 () -> String {
        return ":P"
    }
//
//    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
//        super.init(nibName: nibName, bundle: nibBundleOrNil)
//    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.title = "Emoji"
    }
    
    @IBAction func buttonSolarLunarPressed(sender : AnyObject) {
        var nextText = ""
        if let currentBtn = self.buttonSolarLunarPhases! as UIButton? {
            let currentBtnText = currentBtn.titleForState(UIControlState.Normal) as String
            if(currentBtnText == "🌞") {
                nextText = "🌝"
            } else if(currentBtnText == "🌝") {
                nextText = "🌕"
            } else if(currentBtnText == "🌕") {
                nextText = "🌖"
            } else if(currentBtnText == "🌖") {
                nextText = "🌗"
            } else if(currentBtnText == "🌗") {
                nextText = "🌘"
            } else if(currentBtnText == "🌘") {
                nextText = "🌚"
            } else if(currentBtnText == "🌚") {
                nextText = "🌑"
            } else if(currentBtnText == "🌑") {
                nextText = "🌒"
            } else if(currentBtnText == "🌒") {
                nextText = "🌓"
            } else if(currentBtnText == "🌓") {
                nextText = "🌔"
            } else if(currentBtnText == "🌔") {
                nextText = "🌞"
            } else {
                nextText = self.😋()
            }
        }
        self.buttonSolarLunarPhases.setTitle(nextText, forState:UIControlState.Normal)
        self.buttonSolarLunarPhases.setTitle(nextText, forState:UIControlState.Highlighted)
    }
    
    @IBAction func buttonRecyclePressed(sender : AnyObject) {
        //toggle the relevant selected button
        buttonRecycleIcon.toggleSelected()
    }
    
    @IBAction func buttonSoundPressed(sender : AnyObject) {
        buttonSound.toggleSelected()
    }
}