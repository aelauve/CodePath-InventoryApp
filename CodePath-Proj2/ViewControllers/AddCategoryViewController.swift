//
//  AddCategoryViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 3/17/21.
//

import UIKit

class AddCategoryViewController: UIViewController {

    @IBOutlet weak var defaultIconImage: UIImageView!
    @IBOutlet weak var chooseImageButton: UIButton!
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var addCategoryButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onChooseImage(_ sender: Any) {
    }
    
    @IBAction func onAddCategory(_ sender: Any) {
        
        // If input is blank, show error message
        if categoryNameTextField.text == ""{
            let alert = UIAlertController(title: "Uh Oh!", message: "Category Name must be filled in.", preferredStyle: UIAlertController.Style.alert)
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
            //Add category to user database
            print("Add success")
        }
    
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
