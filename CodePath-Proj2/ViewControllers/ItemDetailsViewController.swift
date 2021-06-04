//
//  ItemDetailsViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 3/17/21.
//

import UIKit
import Parse

class ItemDetailsViewController: UIViewController {
    
    var itemID: String = ""
    var categoryID: String = ""
    var allCategoryID: String = ""
    var invID: String = ""
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var lightColor: UIColor = UIColor(named: "GreenLight")!
    var itemSegueArray: [String] = []
    
    //experimenting
    var instanceOfIVC: InventoryViewController!

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCategory: UILabel!
    @IBOutlet weak var itemExpiration: UILabel!
    @IBOutlet weak var itemNotes: UITextView!
    @IBOutlet weak var itemAmount: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var countStepper: UIStepper!
    @IBOutlet weak var shopListButton: UIButton!
    
    
    
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
        print(itemSegueArray[2])
        print(type(of: itemSegueArray[2]))
        if itemSegueArray[2] == "" {
            itemExpiration.text = "No Expiration"
        } else {
            itemExpiration.text = itemSegueArray[2]
        }
        itemNotes.text = itemSegueArray[3]
        itemAmount.text = itemSegueArray[4]
        
        //buttons
        updateButton.backgroundColor = regColor
        updateButton.layer.cornerRadius = 5
        shopListButton.backgroundColor = regColor
        shopListButton.layer.cornerRadius = 5
        
        //outerView
        outerView.backgroundColor = lightColor
        outerView.layer.cornerRadius = 10
        outerView.layer.opacity = 0.5
        
        //stepper
        countStepper.value = Double(itemAmount.text!) ?? 0
        countStepper.minimumValue = 1

    }
    
    @IBAction func removeItem(_ sender: Any) {
        
        // 1. Delete Item from Database
        
        let deleteAttributesOnly = true
        let query = PFQuery(className:"Item")
        query.getObjectInBackground(withId: itemID) { (parseObject, error) in
            
            if error != nil {
              print(error)
            } else if parseObject != nil {
              if deleteAttributesOnly {
                parseObject!.remove(forKey: "itemName")
                parseObject!.remove(forKey: "itemIcon")
                parseObject!.remove(forKey: "expiration")
                parseObject!.remove(forKey: "itemCount")
                parseObject!.remove(forKey: "notes")
                parseObject!.remove(forKey: "itemCategory")
                parseObject!.saveInBackground()
              } else {
                parseObject!.deleteInBackground()
              }
            }
        }
        
        // 2. Remove item from Category
        
        let query2 = PFQuery(className:"Category")
        query2.getObjectInBackground(withId: categoryID) { (category, error) in
          if error == nil && category != nil {
            var tempArray: [String] = []
            for item in category!["itemList"] as! [String]{
                if item != self.itemID {
                    tempArray.append(item)
                }
            }
            
            category!["itemList"] = tempArray
            category!.saveInBackground()
            
          }
        }
        
        
        // 3. Remove item from "All" category
        
        let query3 = PFQuery(className:"Category")
        query3.getObjectInBackground(withId: allCategoryID) { (category, error) in
          if error == nil && category != nil {
            var tempArray: [String] = []
            for item in category!["itemList"] as! [String]{
                if item != self.itemID {
                    tempArray.append(item)
                }
            }
            
            category!["itemList"] = tempArray
            category!.saveInBackground()
            
          }
        }
        
        // 4. Dismiss VC
        
        self.dismiss(animated: true, completion: {
            DispatchQueue.main.async {
                //self.instanceOfIVC.itemCollection.reloadData()
                self.instanceOfIVC.viewDidLoad()
            }
        })
        
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            DispatchQueue.main.async {
                //self.instanceOfIVC.itemCollection.reloadData()
                self.instanceOfIVC.viewDidLoad()
            }
        })
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        itemAmount.text = Int(sender.value).description
    }
    
    
    @IBAction func onUpdate(_ sender: Any) {
        
        let query = PFQuery(className:"Item")

        print("itemID: ", itemID)
        query.getObjectInBackground(withId: itemID) { (parseObject, error) in
          if error != nil {
            print(error)
          } else if parseObject != nil {
            //parseObject["itemIcon"] = PFFile(name:"resume.txt", data:"My string content".dataUsingEncoding(NSUTF8StringEncoding))
            parseObject!["itemCount"] = Int(self.itemAmount.text!)
            parseObject!["notes"] = self.itemNotes.text

            parseObject!.saveInBackground()
          }
        }
        
        self.dismiss(animated: true, completion: {
            DispatchQueue.main.async {
                //self.instanceOfIVC.itemCollection.reloadData()
                self.instanceOfIVC.viewDidLoad()
            }
        })
        
    }
    
    @IBAction func addToShopList(_ sender: Any) {
        
        let user = PFUser.current()
        let query = PFQuery(className:"ShoppingList")
        query.getObjectInBackground(withId: user!["shoppingList"] as! String) { (parseObject, error) in
          if error != nil {
            print(error)
          } else if parseObject != nil {
            var temp = parseObject!["itemsToShop"] as! [String]
            temp.append(self.itemName.text!)
            parseObject!["itemsToShop"] = temp

            parseObject!.saveInBackground()
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
