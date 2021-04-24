//
//  ViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 2/20/21.
//

import UIKit
import Parse

class InventoryViewController: UIViewController {
    
    var dictCategory: [String : String] = [:]
    var categoryIDs: [String] = [String]()
    var categoryNames: [String] = [String]()
    var chosenCategory: String = "All"
    var chosenCategoryID: String = ""
    
    var dictItems: [String : String] = [:]
    var itemIDs: [String] = [String]()
    var itemNames: [String] = [String]()
    var chosenItem: String = ""
    var chosenItemID: String = ""
    var itemArray: [[String]] = [[]]

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var categoryPickCollection: UICollectionView!
    @IBOutlet weak var itemCollection: UICollectionView!
    
    var inventoryID: String = ""
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var lightColor: UIColor = UIColor(named: "GreenLight")!
    
    let addCategoryCollectionViewIdentifier = "addCategoryCell"
    let categoryCollectionViewIdentifier = "horizCategoryCell"
    let itemCollectionViewIdentifier = "inventoryItemCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load colors
        getColorScheme()
        backButton.tintColor = regColor
        
        getCategories { (valuesINeed , error) in
            
            if let error = error {
                print(error)
            }

            self.dictCategory = valuesINeed!
            self.categoryIDs = Array(self.dictCategory.values)
            self.categoryNames = Array(self.dictCategory.keys)
            
            print(self.dictCategory , " the values i wanted all along ")
            print("category names ", self.categoryNames)
            
            self.categoryPickCollection.reloadData()
            
        }
        
        getItems { (itemArr, itemDictionary , error) in
            
            if let error = error {
                print(error)
            }
        
            self.itemArray = itemArr!
            self.dictItems = itemDictionary!
            print(self.dictItems , " the values i wanted all along ")
            self.itemIDs = Array(self.dictItems.values)
            self.itemNames = Array(self.dictItems.keys)
            print("item names ", self.itemNames)
            
            self.itemCollection.reloadData()
            
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Load colors
        getColorScheme()
        backButton.tintColor = regColor
        
        getCategories { (valuesINeed , error) in
            
            if let error = error {
                print(error)
            }

            self.dictCategory = valuesINeed!
            self.categoryIDs = Array(self.dictCategory.values)
            self.categoryNames = Array(self.dictCategory.keys)
            
            print(self.dictCategory , " the values i wanted all along ")
            print("category names ", self.categoryNames)
            
            self.categoryPickCollection.reloadData()
            
        }
        
        getItems { (itemArr, itemDictionary , error) in
            
            if let error = error {
                print(error)
            }
        
            self.itemArray = itemArr!
            self.dictItems = itemDictionary!
            print(self.dictItems , " the values i wanted all along ")
            self.itemIDs = Array(self.dictItems.values)
            self.itemNames = Array(self.dictItems.keys)
            print("item names ", self.itemNames)
            
            self.itemCollection.reloadData()
            
        }

    }

    
    func getColorScheme(){
        let user = PFUser.current()
        
        let color: String = user!["colorPalette"] as! String
        switch color {
        case "Green":
            self.regColor = UIColor(named: "GreenReg")!
            self.lightColor = UIColor(named: "GreenLight")!
        case "Teal":
            self.regColor = UIColor(named: "TealReg")!
            self.lightColor = UIColor(named: "TealLight")!
        case "Blue":
            self.regColor = UIColor(named: "BlueReg")!
            self.lightColor = UIColor(named: "BlueLight")!
        case "Purple":
            self.regColor = UIColor(named: "PurpleReg")!
            self.lightColor = UIColor(named: "PurpleLight")!
        case "Yellow":
            self.regColor = UIColor(named: "YellowReg")!
            self.lightColor = UIColor(named: "YellowLight")!
        case "Red":
            self.regColor = UIColor(named: "RedReg")!
            self.lightColor = UIColor(named: "RedLight")!
        case "Pink":
            self.regColor = UIColor(named: "PinkReg")!
            self.lightColor = UIColor(named: "PinkLight")!
        case "Black":
            self.regColor = UIColor(named: "BlackReg")!
            self.lightColor = UIColor(named: "BlackLight")!
        default:
            self.regColor = UIColor(named: "GreenReg")!
            self.lightColor = UIColor(named: "GreenLight")!
        }
    }
    
    func getCategories(completionHandler : @escaping (_ dictOfCategories : [String : String]? , _ error : Error?) -> () ) {
        var finalDict :[String : String] = [:]
        let query = PFQuery(className: "Inventory")
        query.getObjectInBackground(withId: inventoryID) { (inventory, error) in
            
            if let error = error {
                completionHandler(nil , error)
            }
            guard let inventory = inventory else { return }
            let categories = inventory["categories"] as! [String]
            var count = categories.count
            for x in categories {
                let query = PFQuery(className: "Category")
                query.getObjectInBackground(withId: x) { (category, error) in
                  if error == nil && category != nil {
                    count -= 1
                    finalDict[category!["categoryName"] as! String] = x
                    if count == 0{
                        completionHandler(finalDict, nil)
                    }
                    
                  }
                }
            }
        }
    }
    
    func getItems(completionHandler : @escaping (_ arrayOfItems : [[String]]?, _ dictOfItems : [String : String]?, _ error : Error?) -> () ) {
        
        var finalDict :[String : String] = [:]
        var finalArray: [[String]] = [[]]
        let query = PFQuery(className: "Category")
        query.getObjectInBackground(withId: chosenCategoryID) { (category, error) in
            
            if let error = error {
                completionHandler(nil , nil, error)
            }
            guard let category = category else { return }
            let items = category["itemList"] as! [String]
            var count = items.count
            for x in items {
                let query = PFQuery(className: "Item")
                query.getObjectInBackground(withId: x) { (item, error) in
                  if error == nil && item != nil {
                    count -= 1
                    finalDict[item!["itemName"] as! String] = x
                    
                    let name = item!["itemName"] as! String
                    let ID = x
                    let itemCount = String(item!["itemCount"] as! Int)
                    
                    finalArray.append([name, ID, itemCount])
                    
                    if count == 0{
                        completionHandler(finalArray, finalDict, nil)
                    }
                    
                  }
                }
            }
        }
    }

    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCategory" {
            let navVCs = segue.destination as! UINavigationController
            let destinationVC = navVCs.viewControllers[0] as! AddCategoryViewController
            destinationVC.inventoryID = inventoryID
            destinationVC.regColor = self.regColor
            destinationVC.lightColor = self.lightColor
        } else if segue.identifier == "addItem" {
            let navVCs = segue.destination as! UINavigationController
            let destinationVC = navVCs.viewControllers[0] as! AddItemViewController
            destinationVC.inventoryID = inventoryID
            destinationVC.pickerData = categoryNames
            destinationVC.categoryObjIDs = categoryIDs
            destinationVC.regColor = self.regColor
            destinationVC.lightColor = self.lightColor
        } else if segue.identifier == "showItemDetails" {
            let navVCs = segue.destination as! UINavigationController
            let destinationVC = navVCs.viewControllers[0] as! ItemDetailsViewController
            destinationVC.itemID = chosenItemID
            destinationVC.itemID = chosenCategoryID
            destinationVC.regColor = self.regColor
            destinationVC.lightColor = self.lightColor
        }
    }
    
    
    @IBAction func addCategory(_ sender: Any) {
        self.performSegue(withIdentifier: "addCategory", sender: nil)
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        self.performSegue(withIdentifier: "addItem", sender: nil)
    }
}

extension InventoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0{
                return CGSize(width: 50, height: 33)
            } else {
                return CGSize(width: 115, height: 33)
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if collectionView == self.categoryPickCollection{
            return dictCategory.count + 1
        }
        else{
            return dictItems.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.categoryPickCollection{

            if indexPath.item == 0{
                let cell = categoryPickCollection.dequeueReusableCell(withReuseIdentifier: addCategoryCollectionViewIdentifier, for: indexPath) as! AddCategoryCollectionCell
                
                cell.addCategoryButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
                cell.addCategoryButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
                cell.addCategoryButton.layer.borderColor = regColor.cgColor
                cell.addCategoryButton.layer.borderWidth = 2.0
                cell.addCategoryButton.layer.cornerRadius = 0.5 * (cell.addCategoryButton).bounds.size.width
                cell.addCategoryButton.tintColor = regColor
                
                return cell
                
            } else{
                let cell = categoryPickCollection.dequeueReusableCell(withReuseIdentifier: categoryCollectionViewIdentifier, for: indexPath) as! HorizCategoryCollectionViewCell
                
                
                //cell.categoryLabel.layer.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                //cell.categoryLabel.layer.borderWidth = 2.0
                cell.categoryLabel.backgroundColor = regColor
                cell.categoryLabel.layer.cornerRadius = 15
                
                if categoryNames.count > indexPath.item - 1{
                
                    let title = categoryNames[indexPath.item-1]
                    cell.categoryLabel.text = title
                } else {
                    cell.categoryLabel.text = "Category"
                }
                
                return cell
            }
            
        }
        else{
            
            let cell = itemCollection.dequeueReusableCell(withReuseIdentifier: itemCollectionViewIdentifier, for: indexPath) as! InventoryCollectionViewCell
            
            print("Creating item cell...")
            
            cell.itemImage.layer.borderWidth = 1.0
            cell.itemImage.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            cell.itemImage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.itemImage.layer.cornerRadius = (cell.itemImage?.frame.size.width ?? 0.0) / 2
            
            let itemDetails = itemArray[indexPath.row]
            print("item details ", itemDetails)
            let itemName = itemDetails[0]
            let itemCount = itemDetails[2]
            
            cell.itemNameLabel.text = itemName
            cell.itemNumberLabel.text = itemCount
            
            cell.layer.cornerRadius = 15
            //cell.layer.borderWidth = 1.0
            cell.backgroundColor = lightColor
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.categoryPickCollection{
            
            if indexPath.item == 0 {
                self.performSegue(withIdentifier: "addCategory", sender: nil)
            } else {
                
                chosenCategory = categoryNames[indexPath.item-1]
                chosenCategoryID = dictCategory[chosenCategory]!
                
                getItems { (itemArr, itemDictionary , error) in
                    
                    if let error = error {
                        print(error)
                    }
                
                    self.itemArray = itemArr!
                    self.dictItems = itemDictionary!
                    print(self.dictItems , " the values i wanted all along ")
                    self.itemIDs = Array(self.dictItems.values)
                    self.itemNames = Array(self.dictItems.keys)
                    print("item names ", self.itemNames)
                    
                    self.itemCollection.reloadData()
                    
                }
            
            }
            
        } else {
            performSegue(withIdentifier: "showItemDetails", sender: nil)
        }
        
      }
    
    
}

