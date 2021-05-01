//
//  ItemDetailsViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 3/17/21.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    var itemID: String = ""
    var categoryID: String = ""
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var lightColor: UIColor = UIColor(named: "GreenLight")!
    var itemSegueArray: [String] = []

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCategory: UILabel!
    @IBOutlet weak var itemExpiration: UILabel!
    @IBOutlet weak var itemNotes: UITextView!
    @IBOutlet weak var itemAmount: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // image
        itemImage.layer.cornerRadius = (itemImage.frame.size.width ) / 2
        itemImage.layer.borderWidth = 1.0
        itemImage.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        itemImage.backgroundColor = lightColor
        
        //labels
        itemName.text = itemSegueArray[0]
        itemCategory.text = itemSegueArray[1]
        itemExpiration.text = itemSegueArray[2]
        itemNotes.text = itemSegueArray[3]
        itemAmount.text = itemSegueArray[4]
        
        //button
        updateButton.backgroundColor = regColor

    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onUpdate(_ sender: Any) {
        
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
