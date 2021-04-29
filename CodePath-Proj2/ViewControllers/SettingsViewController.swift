//
//  SettingsViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 4/20/21.
//

import UIKit
import Parse
import AlamofireImage

class SettingsViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //variables for interactive outlets
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var tealButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var pinkButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var changePFPButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    //global variables
    let user = PFUser.current()
    let dataView = DataViewController()
    
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var chosenColor: String = "Green"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //setting name label
        let firstName = user!["firstName"] as? String
        let lastName = user!["lastName"] as? String
        userNameLabel.text = firstName! + " " + lastName!
        
        //visual design of buttons
        greenButton.layer.cornerRadius = 0.5 * (greenButton).bounds.size.width
        tealButton.layer.cornerRadius = 0.5 * (tealButton).bounds.size.width
        blueButton.layer.cornerRadius = 0.5 * (blueButton).bounds.size.width
        purpleButton.layer.cornerRadius = 0.5 * (purpleButton).bounds.size.width
        yellowButton.layer.cornerRadius = 0.5 * (yellowButton).bounds.size.width
        redButton.layer.cornerRadius = 0.5 * (redButton).bounds.size.width
        pinkButton.layer.cornerRadius = 0.5 * (pinkButton).bounds.size.width
        blackButton.layer.cornerRadius = 0.5 * (blackButton).bounds.size.width
        changePFPButton.backgroundColor = UIColor.white
        changePFPButton.layer.cornerRadius = 5
        changePFPButton.layer.masksToBounds = true
        changePFPButton.setTitleColor(regColor, for: .normal)
        backgroundView.backgroundColor = regColor
        backgroundView.layer.cornerRadius = 15
        
        //visual design of profile picture
        if((user?["profileImage"]) != nil)
        {
            let imageFile = user!["profileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            profilePicImageView.af_setImage(withURL: url)
            profilePicImageView.layer.borderWidth = 1.0
                    profilePicImageView.layer.masksToBounds = false
                    profilePicImageView.layer.borderColor = UIColor.white.cgColor
                    profilePicImageView.layer.cornerRadius = profilePicImageView.frame.size.width / 2
                    profilePicImageView.clipsToBounds = true
        }
        else{
            profilePicImageView.image = UIImage(systemName: "person.fill")
            profilePicImageView.layer.borderWidth = 1.0
                    profilePicImageView.layer.masksToBounds = false
                    profilePicImageView.layer.borderColor = UIColor.white.cgColor
                    profilePicImageView.layer.cornerRadius = profilePicImageView.frame.size.width / 2
                    profilePicImageView.clipsToBounds = true
                    
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
////        let myUserInfo = UserInfoViewController()
////        myUserInfo.delegate = self
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    
//    func backFromSettings() -> String {
//        return chosenColor
//    }
//    
    
    func setColorSelected(){
        //resetting button designs
        greenButton.layer.borderWidth = 0
        blueButton.layer.borderWidth = 0
        tealButton.layer.borderWidth = 0
        purpleButton.layer.borderWidth = 0
        yellowButton.layer.borderWidth = 0
        redButton.layer.borderWidth = 0
        pinkButton.layer.borderWidth = 0
        blackButton.layer.borderWidth = 0
        
        //updating border of new color option
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
        
        //var chosenColor = "Green"
        
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
        
        
        user!["colorPalette"] = chosenColor
        user?.saveInBackground()
        
        
        
        
    }
    //PFFileObject(name: "image.png", data: user!["profileImage"].image!.pngData())
    @IBAction func onBack(_ sender: Any) {
        
        let imageData = profilePicImageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        user!["profileImage"] = file
        
        user!.saveInBackground{
            (success, error) in if success {
                print("success")
            } else{
                print("error")
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
   
    
    
    //Updating screen for chosen colors
    @IBAction func GBttnTouched(_ sender: UIButton) {
        changePFPButton.setTitleColor(UIColor.systemGreen, for: .normal)
        backgroundView.backgroundColor = UIColor.systemGreen
        chosenColor = "Green"
        regColor = UIColor(named: "GreenReg")!
        setColorSelected()
    }
    @IBAction func TBttnTouched(_ sender: UIButton) {
        changePFPButton.setTitleColor(UIColor.systemTeal, for: .normal)
        backgroundView.backgroundColor = UIColor.systemTeal
        regColor = UIColor(named: "TealReg")!
        chosenColor = "Teal"
        setColorSelected()
        
    }
    @IBAction func BBttnTouched(_ sender: UIButton) {
        changePFPButton.setTitleColor(UIColor.blue, for: .normal)
        backgroundView.backgroundColor = UIColor.blue
        regColor = UIColor(named: "BlueReg")!
        chosenColor = "Blue"
        setColorSelected()
    }
    
    @IBAction func PBttnTouched(_ sender: UIButton) {
        changePFPButton.setTitleColor(UIColor.systemPurple, for: .normal)
        backgroundView.backgroundColor = UIColor.systemPurple
        regColor = UIColor(named: "PurpleReg")!
        chosenColor = "Purple"
        setColorSelected()
    }
    
    @IBAction func YBttnTouched(_ sender: UIButton) {
        changePFPButton.setTitleColor(UIColor.systemYellow, for: .normal)
        backgroundView.backgroundColor = UIColor.systemYellow
        regColor = UIColor(named: "YellowReg")!
        chosenColor = "Yellow"
        setColorSelected()
    }
    @IBAction func RBttnTouched(_ sender: UIButton) {
        changePFPButton.setTitleColor(UIColor.red, for: .normal)
        backgroundView.backgroundColor = UIColor.red
        regColor = UIColor(named: "RedReg")!
        chosenColor = "Red"
        setColorSelected()
    }
    @IBAction func PnkBttnTouched(_ sender: UIButton) {
        changePFPButton.setTitleColor(UIColor.systemPink, for: .normal)
        backgroundView.backgroundColor = UIColor.systemPink
        regColor = UIColor(named: "PinkReg")!
        chosenColor = "Pink"
        setColorSelected()
    }
    
    @IBAction func BlkBttnTouched(_ sender: Any) {
        changePFPButton.setTitleColor(UIColor.black, for: .normal)
        backgroundView.backgroundColor = UIColor.black
        regColor = UIColor(named: "BlackReg")!
        chosenColor = "Black"
        setColorSelected()
    }
    
    //Uploading photo
    
    @IBAction func changingPFP(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 80, height: 80)
        let scaledImage = image.af_imageScaled(to: size)
        
        profilePicImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
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
