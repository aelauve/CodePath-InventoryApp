//
//  LoginViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 3/16/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var lightColor: UIColor = UIColor(named: "GreenLight")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.backgroundColor = regColor
        //loginButton.layer.borderColor = UIColor(named: "GreenLight")?.cgColor
        loginButton.layer.cornerRadius = 10
        
        signUpButton.backgroundColor = regColor
        //signUpButton.layer.borderColor = #colorLiteral(red: 0.852301836, green: 0.4426146448, blue: 0.608592689, alpha: 1)
        signUpButton.layer.cornerRadius = 10

    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        if (username == "") {
            
            let alert = UIAlertController(title: "Invalid", message: "Username must not be left blank", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            {
                (UIAlertAction) -> Void in
            }
            alert.addAction(alertAction)
            present(alert, animated: true)
            {
                () -> Void in
            }
            
        } else if (password == ""){
            
            let alert = UIAlertController(title: "Invalid", message: "Password must not be left blank", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            {
                (UIAlertAction) -> Void in
            }
            alert.addAction(alertAction)
            present(alert, animated: true)
            {
                () -> Void in
            }
            
        }

        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
          
            if user != nil {
            
                let user = PFUser.current()
                
                let color: String = user!["colorPalette"] as! String
                switch color {
                case "Green":
                    self.regColor = UIColor(named: "GreenReg")!
                    self.lightColor = UIColor(named: "GreenLight")!
                case "Teal":
                    self.regColor = UIColor(named: "TealReg")!
                    self.lightColor = UIColor(named: "TealLight")!
                case "Blue":
                    self.regColor = UIColor(named: "BlueReg")!
                    self.lightColor = UIColor(named: "BlueLight")!
                case "Purple":
                    self.regColor = UIColor(named: "PurpleReg")!
                    self.lightColor = UIColor(named: "PurpleLight")!
                case "Yellow":
                    self.regColor = UIColor(named: "YellowReg")!
                    self.lightColor = UIColor(named: "YellowLight")!
                case "Red":
                    self.regColor = UIColor(named: "RedReg")!
                    self.lightColor = UIColor(named: "RedLight")!
                case "Pink":
                    self.regColor = UIColor(named: "PinkReg")!
                    self.lightColor = UIColor(named: "PinkLight")!
                case "Black":
                    self.regColor = UIColor(named: "BlackReg")!
                    self.lightColor = UIColor(named: "BlackLight")!
                default:
                    self.regColor = UIColor(named: "GreenReg")!
                    self.lightColor = UIColor(named: "GreenLight")!
                }
                
                if (user!["inventories"] != nil){
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
            else {
                
                let alert = UIAlertController(title: "Welcome!", message: "Let's add your first inventory!", preferredStyle: UIAlertController.Style.alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                {
                    UIAlertAction in
                    self.performSegue(withIdentifier: "addInventorySegue", sender: nil)
                }
                alert.addAction(alertAction)
                self.present(alert, animated: true)
                {
                    () -> Void in
                }
            }
          } else {
            print(username)
            print(password)
            print("Error: \(String(describing: error?.localizedDescription))")
          }
        
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {

        self.performSegue(withIdentifier:"onSignUp", sender: nil)

    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "loginSegue" {
//            let navVC = segue.destination as! UINavigationController
//            let destinationVC = navVC.viewControllers[0] as! InventorySelectorViewController
//            destinationVC.regColor = self.regColor
//            destinationVC.lightColor = self.lightColor
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
