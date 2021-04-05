//
//  DataViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 4/2/21.
//

import UIKit
import Parse

class DataViewController: UIViewController {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var invNameLabel: UILabel!
    @IBOutlet weak var invIDLabel: UILabel!
    @IBOutlet weak var sharedWithLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    
    var index: Int?
    var nameLabel: String?
    var idLabel: String?
    var sharedWith: String?
    var createdAt: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outerView.layer.cornerRadius = 20
        outerView.layer.opacity = 0.5
        
        invNameLabel.text = nameLabel
        //invNameLabel.sizeToFit()
        
        invIDLabel.text = idLabel
        //invIDLabel.sizeToFit()
        
        sharedWithLabel.text = sharedWith
        //sharedWithLabel.sizeToFit()
        
        createdLabel.text = createdAt
        //createdLabel.sizeToFit()

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
