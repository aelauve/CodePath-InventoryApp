//
//  AddItemViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 2/20/21.
//

import UIKit
import Parse

class AddItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var itemImageView: UIImageView! {
        didSet {
            itemImageView.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var addToInventoryButton: UIButton!
    var allCategoryID: String = ""
    //ignore next line
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var amountTextBox: UITextField!
    @IBOutlet weak var expirationSwitch: UISwitch!
    @IBOutlet weak var expirationDate: UIDatePicker!
    @IBOutlet weak var notesTextBox: UITextView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var dictCategories: [String : String] = [:]
    var pickerData: [String] = [String]()
    var categoryObjIDs: [String] = [String]()
    var chosenCategory: String = ""
    var chosenCatID: String = ""
    var inventoryID: String = ""
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var lightColor: UIColor = UIColor(named: "GreenLight")!
    //Still need to add actions for the buttons
    //Also need to add text fields
    
    var instanceOfIVC: InventoryViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // **** Set itemImage to default image for that category!
        
        //Temporary styling of item image
        itemImageView.layer.cornerRadius = (itemImageView?.frame.size.width ?? 0.0) / 2
        //itemImageView.layer.borderWidth = 1.0
        //itemImageView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        //itemImageView.backgroundColor = lightColor
        itemImageView.tintColor = lightColor
        
        //Styling border of Name and Amount text boxes
        nameTextBox.layer.borderWidth = 1.0
        nameTextBox.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        nameTextBox.layer.cornerRadius = 5
        
        amountTextBox.layer.borderWidth = 1.0
        amountTextBox.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        amountTextBox.layer.cornerRadius = 5
        
        //Styling '+' and '-' buttons
        plusButton.layer.cornerRadius = 5
        //plusButton.layer.borderWidth = 1.0
        //plusButton.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        
        minusButton.layer.cornerRadius = 5
       // minusButton.layer.borderWidth = 1.0
        //minusButton.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        
        //Styling Notes text view
        //notesTextBox.layer.borderWidth = 1.0
        //notesTextBox.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        notesTextBox.layer.cornerRadius = 5
        
        //Styling 'Add to' Button
        addToInventoryButton.layer.cornerRadius = 10
        //addToInventoryButton.layer.borderWidth = 2.0
        //addToInventoryButton.layer.borderColor = #colorLiteral(red: 1, green: 0.3807129264, blue: 0.4381764233, alpha: 1)
        addToInventoryButton.backgroundColor = regColor
        
        //Adding bordert to Notes Text Box
        notesTextBox.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        notesTextBox.layer.borderWidth = 1.0
        
//        categoryPicker.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        categoryPicker.layer.borderWidth = 1.0
//
//        expirationDate.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        expirationDate.layer.borderWidth = 1.0
        
        
        //Connect picker data
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        dictCategories.removeValue(forKey: "All")
        self.pickerData = Array(self.dictCategories.keys)
        print("picker data = ", pickerData)
        self.categoryObjIDs = Array(self.dictCategories.values)
        
        //Input temporary data
        //pickerData = ["Category1", "Category2", "Category3"]
//        chosenCategory = pickerData[0]
//        chosenCatID = categoryObjIDs[0]
        
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
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Capture the picker view selection
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        chosenCategory = pickerData[row]
        chosenCatID = categoryObjIDs[row]

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
    
    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
        print("you tapped me!")
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
            if expirationSwitch.isOn {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yy"
                let dateString = dateFormatter.string(from: expirationDate.date)
                item["expiration"] = expirationDate.date
                //item["expiration"] = dateString
            }
            item["itemCount"] = (Int)(amountTextBox.text!)
            item["notes"] = notesTextBox.text
                
            item.saveInBackground { (success, error) in
                if success {
                    
                    let itemID = item.objectId!
                    
                    let query = PFQuery(className: "Category")
                    query.getObjectInBackground(withId: self.chosenCatID) { (category, error) in
                        if error == nil && category != nil {
                            if category!["itemList"] == nil {
                                category!["itemList"] = [itemID]
                            } else {
                                var catItems: [String] = category!["itemList"] as! [String]
                                catItems.append(itemID)
                                category!["itemList"] = catItems
                            }
                            
                            category!.saveInBackground() { (success, error) in
                                if success {
                                    
                                    
                                    // Add to "All" Category
                                    let query = PFQuery(className: "Category")
                                    query.getObjectInBackground(withId: self.allCategoryID) { (category, error) in
                                        if error == nil && category != nil {
                                            if category!["itemList"] == nil {
                                                category!["itemList"] = [itemID]
                                            } else {
                                                var catItems: [String] = category!["itemList"] as! [String]
                                                catItems.append(itemID)
                                                category!["itemList"] = catItems
                                            }
                                            category!.saveInBackground()
                                        }
                                    }
                                    
                                    self.dismiss(animated: true, completion: {
                                        DispatchQueue.main.async {
                                            //self.instanceOfIVC.itemCollection.reloadData()
                                            self.instanceOfIVC.viewDidLoad()
                                        }
                                    })
                                } else {
                                    print("Inventory save error")
                                    print("Error: \(error?.localizedDescription)")
                                }
                            }
                        } else {
                            print("nil category")
                        }
                    }
            
                } else {
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }

    }


}
