//
//  DataViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 4/2/21.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var invNameLabel: UILabel!
    @IBOutlet weak var invIDLabel: UILabel!
    @IBOutlet weak var sharedWithLabel: UILabel!
    
    var index: Int?
    var nameLabel: String?
    var idLabel: String?
    var sharedWith: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invNameLabel.text = nameLabel
        invIDLabel.text = idLabel
        sharedWithLabel.text = sharedWith

        // Do any additional setup after loading the view.
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
