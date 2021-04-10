//
//  AddItemViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 2/20/21.
//

import UIKit
import Parse

class AddItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var addToInventoryButton: UIButton!
    //ignore next line
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var amountTextBox: UITextField!
    @IBOutlet weak var expirationSwitch: UISwitch!
    @IBOutlet weak var expirationDate: UIDatePicker!
    @IBOutlet weak var notesTextBox: UITextView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var pickerData: [String] = [String]()
    var chosenCategory: String = ""
    
    //Still need to add actions for the buttons
    //Also need to add text fields
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // **** Set itemImage to default image for that category!
        
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
        notesTextBox.layer.borderWidth = 1.0
        notesTextBox.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        notesTextBox.layer.cornerRadius = 5
        
        //Styling 'Add to' Button
        addToInventoryButton.layer.cornerRadius = 10
        addToInventoryButton.layer.borderWidth = 2.0
        addToInventoryButton.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        addToInventoryButton.layer.backgroundColor = #colorLiteral(red: 1, green: 0.5132452846, blue: 0.6042660475, alpha: 1)
        
        
        //Connect picker data
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        //Input temporary data
        pickerData = ["Category1", "Category2", "Category3"]
        chosenCategory = pickerData[0]
        
    }
    
    func loadCategories() {
        // Get current inventory's list of categories
        
        // Populate pickerData with the NAMES of these categories
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Capture the picker view selection
    private func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        chosenCategory = pickerData[row]
    }
    
    
    @IBAction func decrementAmount(_ sender: Any) {
        var count = Int(amountTextBox.text!)
        if count! > 1{
            count = count! - 1
            amountTextBox.text = String(count!)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Amount must be greater than 0", preferredStyle: UIAlertController.Style.alert)
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
    
    @IBAction func addToInventoryClicked(_ sender: Any) {
        
        // If input is blank, show error message
        if nameTextBox.text == ""{
            let alert = UIAlertController(title: "Uh Oh!", message: "Name must be filled in.", preferredStyle: UIAlertController.Style.alert)
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
            //Add item to category in user database
            let item = PFObject(className: "Item")
            
            item["itemName"] = nameTextBox.text
            item["itemCategory"] = chosenCategory
            item["itemIcon"] = "None"   //temporary
            if expirationSwitch.isOn {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yy"
                let dateString = dateFormatter.string(from: expirationDate.date)
                item["expiration"] = dateString
            }
            item["itemCount"] = (Int)(amountTextBox.text!)
            item["notes"] = notesTextBox.text
                
            item.saveInBackground { (success, error) in
                if success {
                    print("Saved!")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }
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
