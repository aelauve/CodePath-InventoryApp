//
//  SignUpViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 3/29/21.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.layer.backgroundColor = #colorLiteral(red: 1, green: 0.5132452846, blue: 0.6042660475, alpha: 1)
        registerButton.layer.borderColor = #colorLiteral(red: 0.852301836, green: 0.4426146448, blue: 0.608592689, alpha: 1)
        registerButton.layer.cornerRadius = 10
    }
    
    @IBAction func onRegister(_ sender: Any) {
        print("Register clicked!")
        
        let username = self.usernameTextField.text
        let password = self.passwordTextField.text
        let email = self.emailTextField.text
        let firstName = self.firstNameTextField.text
        let lastName = self.lastNameTextField.text
        
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
            
        } else if (email == ""){

            let alert = UIAlertController(title: "Invalid", message: "Email must not be left blank", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            {
                (UIAlertAction) -> Void in
            }
            alert.addAction(alertAction)
            present(alert, animated: true)
            {
                () -> Void in
            }
            
        } else if (firstName == ""){

            let alert = UIAlertController(title: "Invalid", message: "First Name must not be left blank", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            {
                (UIAlertAction) -> Void in
            }
            alert.addAction(alertAction)
            present(alert, animated: true)
            {
                () -> Void in
            }
            
        } else if (lastName == ""){

            let alert = UIAlertController(title: "Invalid", message: "Last Name must not be left blank", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            {
                (UIAlertAction) -> Void in
            }
            alert.addAction(alertAction)
            present(alert, animated: true)
            {
                () -> Void in
            }
            
        } else {
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium) as UIActivityIndicatorView
            spinner.startAnimating()
            
            let user = PFUser()
            user.username = username
            user.password = password
            user.email = email
            user["firstName"] = firstName
            user["lastName"] = lastName

            user.signUpInBackground { (success, error) in
                if success {
                    self.performSegue(withIdentifier:"signUpSuccessful", sender: nil)
                } else {
                    print("Error: \(String(describing: error?.localizedDescription))")
                }
            }
        }
    
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
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
