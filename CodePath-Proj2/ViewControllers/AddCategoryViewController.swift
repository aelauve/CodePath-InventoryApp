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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
