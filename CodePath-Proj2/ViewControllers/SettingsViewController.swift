//
//  SettingsViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 4/20/21.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var tealButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var pinkButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    
    var regColor: UIColor = UIColor(named: "GreenReg")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greenButton.layer.cornerRadius = 0.5 * (greenButton).bounds.size.width
        tealButton.layer.cornerRadius = 0.5 * (tealButton).bounds.size.width
        blueButton.layer.cornerRadius = 0.5 * (blueButton).bounds.size.width
        purpleButton.layer.cornerRadius = 0.5 * (purpleButton).bounds.size.width
        yellowButton.layer.cornerRadius = 0.5 * (yellowButton).bounds.size.width
        redButton.layer.cornerRadius = 0.5 * (redButton).bounds.size.width
        pinkButton.layer.cornerRadius = 0.5 * (pinkButton).bounds.size.width
        blackButton.layer.cornerRadius = 0.5 * (blackButton).bounds.size.width
        
    }
    
    func setColorSelected(){
        if regColor == UIColor(named: "GreenReg")! {
            greenButton.layer.borderWidth = 2.0
        } else if regColor == UIColor(named: "TealReg")! {
            tealButton.layer.borderWidth = 2.0
        } else if regColor == UIColor(named: "BlueReg")! {
            blueButton.layer.borderWidth = 2.0
        } else if regColor == UIColor(named: "PurpleReg")! {
            purpleButton.layer.borderWidth = 2.0
        } else if regColor == UIColor(named: "YellowReg")! {
            yellowButton.layer.borderWidth = 2.0
        } else if regColor == UIColor(named: "RedReg")! {
            redButton.layer.borderWidth = 2.0
        } else if regColor == UIColor(named: "PinkReg")! {
            pinkButton.layer.borderWidth = 2.0
        } else if regColor == UIColor(named: "BlackReg")! {
            blackButton.layer.borderWidth = 2.0
        }
        
    }
    
    @IBAction func colorChanged(_ sender: UIButton) {
        
        var chosenColor = "Green"
        
        if sender.restorationIdentifier == "green" {
            chosenColor = "Green"
        }
        else if sender.restorationIdentifier == "teal"{
            chosenColor = "Teal"
        }
        else if sender.restorationIdentifier == "blue"{
            chosenColor = "Blue"
        }
        else if sender.restorationIdentifier == "purple"{
            chosenColor = "Purple"
        }
        else if sender.restorationIdentifier == "yellow"{
            chosenColor = "Yellow"
        }
        else if sender.restorationIdentifier == "red"{
            chosenColor = "Red"
        }
        else if sender.restorationIdentifier == "pink"{
            chosenColor = "Pink"
        }
        else if sender.restorationIdentifier == "black"{
            chosenColor = "Black"
        }
        
        let user = PFUser.current()
        user!["colorPalette"] = chosenColor
        user?.saveInBackground()
        
        
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
