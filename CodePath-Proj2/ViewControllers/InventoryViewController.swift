//
//  ViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 2/20/21.
//

import UIKit
import Parse

class InventoryViewController: UIViewController {
    
    //var categories = ["All", "Meat", "Dairy", "Cleaning", "Misc"]
    var categories: [String] = [String]()
    var categoryNames: [String] = [String]()
    var items: [String] = [String]()

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var categoryPickCollection: UICollectionView!
    @IBOutlet weak var itemCollection: UICollectionView!
    
    var inventoryID: String = ""
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var lightColor: UIColor = UIColor(named: "GreenLight")!
    
    let addCategoryCollectionViewIdentifier = "addCategoryCell"
    let categoryCollectionViewIdentifier = "horizCategoryCell"
    let itemCollectionViewIdentifier = "inventoryItemCell"
    
    let myGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.tintColor = regColor
        
        
//        categoryPickCollection.dataSource = self
//        categoryPickCollection.delegate = self

        getCategories()
        categoryPickCollection.reloadData()
        itemCollection.reloadData()

    }

    
    func getCategories() {
        // Get Category objectIds
        myGroup.enter()
        let query = PFQuery(className: "Inventory")
        query.getObjectInBackground(withId: inventoryID) { (inventory, error) in
          if error == nil && inventory != nil {

            self.categories = inventory!["categories"] as! [String]
            print("Categories: \(self.categories)")
            
            for x in self.categories {
                print("x = \(x)")
                let query = PFQuery(className: "Category")
                query.getObjectInBackground(withId: x) { (category, error) in
                  if error == nil && category != nil {
                    self.categoryNames.append(category!["categoryName"] as! String)
                    print("Category name: \(category!["categoryName"] as! String)")
                    self.categoryPickCollection.reloadData()
                  } else {
                    print(error)
                  }
                }
            }
            
            
            if inventory!["itemList"] != nil {
                self.items = inventory!["items"] as! [String]
                //self.itemCollection.reloadData()
            } else {
                self.items = []
                //self.itemCollection.reloadData()
            }
            
          } else {
            print(error)
          }
        }
        myGroup.leave()
        
        myGroup.notify(queue: .main){
            self.categoryPickCollection.reloadData()
            self.itemCollection.reloadData()
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
            destinationVC.categoryObjIDs = categories
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
            return categories.count + 1
        }
        else{
            return items.count
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
            
            
            let query = PFQuery(className: "Item")
            query.getObjectInBackground(withId: items[indexPath.row]) { (item, error) in
              if error == nil && item != nil {
                cell.itemNameLabel.text = item!["itemName"] as! String
                cell.itemNumberLabel.text = String(item!["itemCount"] as! Int)
              } else {
                print("Error getting item")
                print(error)
              }
            }
            
//            cell.itemNameLabel.text = "Garlic"
//            cell.itemNumberLabel.text = String(2)
            
            
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
                
                let selectedCat = categories[indexPath.item-1]
                print("Selected: \(selectedCat)")

                let query = PFQuery(className: "Category")
                query.getObjectInBackground(withId: selectedCat) { (category, error) in
                  if error == nil && category != nil {
                    if category!["items"] != nil {
                        self.items = category!["itemList"] as! [String]
                        print("Items not nil: \(self.items)")
                        self.itemCollection.reloadData()
                    } else {
                        self.items = []
                        print("Items nil: \(self.items)")
                        self.itemCollection.reloadData()
                    }
                  } else {
                    self.items = []
                    print("Category nil: \(self.items)")
                    self.itemCollection.reloadData()
                  }
                }
            }
            
        } else {
            performSegue(withIdentifier: "showItemDetails", sender: nil)
        }
        
      }
    
    
}

