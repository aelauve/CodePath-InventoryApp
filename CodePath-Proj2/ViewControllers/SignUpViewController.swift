//
//  SignUpViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 3/29/21.
//

import UIKit
//import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onRegister(_ sender: Any) {
        print("Register clicked!")
        
//        let user = PFUser()
//        user.username = usernameTextField.text
//        user.password = passwordField.text
//        user.firstName = passwordTextField.text
//        user.lastName = lastNameTextField.text
//        user.email = emailTextField.text
//
//        user.signUpInBackground { (success, error) in
//            if success {
//                self.performSegue(withIdentifier:"signUpSuccessful", sender: nil)
//            } else {
//                print("Error: \(String(describing: error?.localizedDescription))")
//            }
//        }
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
