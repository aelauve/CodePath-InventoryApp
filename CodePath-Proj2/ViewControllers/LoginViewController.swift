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
    
    let colorPaletteReg = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.backgroundColor = colorPaletteReg as? CGColor
        loginButton.layer.borderColor = #colorLiteral(red: 0.852301836, green: 0.4426146448, blue: 0.608592689, alpha: 1)
        loginButton.layer.cornerRadius = 10
        
        signUpButton.layer.backgroundColor = #colorLiteral(red: 1, green: 0.5132452846, blue: 0.6042660475, alpha: 1)
        signUpButton.layer.borderColor = #colorLiteral(red: 0.852301836, green: 0.4426146448, blue: 0.608592689, alpha: 1)
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
                if (user!["inventories"] != nil){
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
            else {
                
                let alert = UIAlertController(title: "Welcome!", message: "Let's add your first inventory.", preferredStyle: UIAlertController.Style.alert)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
