//
//  AddInventoryViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 3/30/21.
//

import UIKit
import Parse

class AddInventoryViewController: UIViewController {

    @IBOutlet weak var inventoryName: UITextField!
    @IBOutlet weak var inventoryID: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var linkButton: UIButton!
    
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var lightColor: UIColor = UIColor(named: "GreenLight")!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.backgroundColor = regColor
        addButton.layer.cornerRadius = 10
        
        linkButton.backgroundColor = regColor
        linkButton.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAdd(_ sender: Any) {
        
        if (inventoryName.text == "") {
            
            let alert = UIAlertController(title: "Invalid", message: "Please provide a name for your inventory", preferredStyle: UIAlertController.Style.alert)
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
        
        else {
            
            let newCat = PFObject(className:"Category")
            newCat["categoryName"] = "All"
            newCat["itemList"] = []
            
            newCat.saveInBackground { (success, error) in
                if success {
                    let catObjID = newCat.objectId!
                    
                    let newInventory = PFObject(className:"Inventory")
                    //Create new Inventory object
                    newInventory["name"] = self.inventoryName.text
                    newInventory["categories"] = [catObjID]
                    newInventory["ownedBy"] = [PFUser.current()?.objectId]
                    
                    newInventory.saveInBackground { (success, error) in
                        if success {
                            let newInventoryObjID = newInventory.objectId!
                            //Update user's inventory array
                            if let currentUser = PFUser.current() {
                                if currentUser["inventories"] == nil {
                                    currentUser["inventories"] = [newInventoryObjID]
                                } else {
                                    var userInv: [String] = currentUser["inventories"] as! [String]
                                    userInv.append(newInventoryObjID)
                                    
                                    currentUser["inventories"] = userInv
                                }

                                currentUser.saveInBackground() { (success, error) in
                                    if success {
                                        print("Saved!")
                                        self.performSegue(withIdentifier:"inventoryAddSuccess", sender: nil)
                                    } else {
                                        print("User save error")
                                        print("Error: \(error?.localizedDescription)")
                                    }
                                }
                            } else {
                                print("nil user")
                            }
                        }
                        else {
                            print("Inventory save error")
                            print("Error: \(error?.localizedDescription)")
                        }
                    }
                    
                } else {
                    print("Category save error")
                    print("Error: \(error?.localizedDescription)")
                }
            }
            
            
            
        }
        
    }
    
    
    @IBAction func onLink(_ sender: Any) {
        
        if (inventoryID.text == "") {
            
            let alert = UIAlertController(title: "Invalid", message: "Please provide an Inventory ID", preferredStyle: UIAlertController.Style.alert)
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
        
        else {
            // **Below not working correctly
            let query = PFQuery(className: "Inventory")
            query.getObjectInBackground(withId: inventoryID.text!) { (inventory, error) in
              if error == nil && inventory != nil {
                
                // Add inventory to current user
                let currentUser = PFUser.current()
                var userInv: [String] = currentUser!["inventories"] as! [String]
                userInv.append((inventory?.objectId)!)
                currentUser!["inventories"] = userInv
                
                currentUser!.saveInBackground() { (success, error) in
                    if success {
                        print("Saved!")
                        self.performSegue(withIdentifier:"inventoryAddSuccess", sender: nil)
                    } else {
                        print("User save error")
                        print("Error: \(error?.localizedDescription)")
                    }
                }

                
              } else {
                    let alert = UIAlertController(title: "Error", message: "Invalid Inventory ID", preferredStyle: UIAlertController.Style.alert)
                    let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                    {
                        (UIAlertAction) -> Void in
                    }
                    alert.addAction(alertAction)
                    self.present(alert, animated: true)
                    {
                        () -> Void in
                    }
              }
        
            }
        }
        
        //Add user to foundInventory
        
        //Add foundInventory to currentUser()
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
