//
//  AddItemViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 2/20/21.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var addToInventoryButton: UIButton!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var amountTextBox: UITextField!
    @IBOutlet weak var expirationSwitch: UISwitch!
    @IBOutlet weak var expirationDate: UIDatePicker!
    
    //Still need to add actions for the buttons
    //Also need to add text fields
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Temporary styling of item image
        itemImageView.layer.cornerRadius = (itemImageView?.frame.size.width ?? 0.0) / 2
        itemImageView.layer.borderWidth = 2.0
        itemImageView.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        itemImageView.layer.backgroundColor = #colorLiteral(red: 1, green: 0.5132452846, blue: 0.6042660475, alpha: 1)
        
        //Styling border of Name and Amount text boxes
        nameTextBox.layer.borderWidth = 1.0
        nameTextBox.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        nameTextBox.layer.cornerRadius = 5
        
        amountTextBox.layer.borderWidth = 1.0
        amountTextBox.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        amountTextBox.layer.cornerRadius = 5
        
        //Styling '+' and '-' buttons
        plusButton.layer.cornerRadius = 5
        plusButton.layer.borderWidth = 1.0
        plusButton.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        
        minusButton.layer.cornerRadius = 5
        minusButton.layer.borderWidth = 1.0
        minusButton.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        
        //Styling Notes text view
        notesTextView.layer.borderWidth = 1.0
        notesTextView.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        notesTextView.layer.cornerRadius = 5
        
        //Styling 'Add to' Button
        addToInventoryButton.layer.cornerRadius = 10
        addToInventoryButton.layer.borderWidth = 2.0
        addToInventoryButton.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        addToInventoryButton.layer.backgroundColor = #colorLiteral(red: 1, green: 0.5132452846, blue: 0.6042660475, alpha: 1)
        

        // Do any additional setup after loading the view.
    }
    @IBAction func decrementAmount(_ sender: Any) {
        var count = Int(amountTextBox.text!)
        if count! > 1{
            count = count! - 1
            amountTextBox.text = String(count!)
        }
    }
    
    @IBAction func incrementAmount(_ sender: Any) {
        var count = Int(amountTextBox.text!)
        count = count! + 1
        amountTextBox.text = String(count!)
    }
    
    @IBAction func expirationToggled(_ sender: Any) {
        if expirationSwitch.isOn == true{
            expirationDate.isEnabled = true
        }
        else {
            expirationDate.isEnabled = false
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
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
