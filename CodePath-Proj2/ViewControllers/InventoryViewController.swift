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
    
    let addCategoryCollectionViewIdentifier = "addCategoryCell"
    let categoryCollectionViewIdentifier = "horizCategoryCell"
    let itemCollectionViewIdentifier = "inventoryItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        categoryPickCollection.dataSource = self
//        categoryPickCollection.delegate = self

        getCategories()

        getCategoryNames()
        categoryPickCollection.reloadData()
        
        // Get
        
//        self.view.addSubview(categoryPickCollection)
//        self.view.addSubview(itemCollection)
    }
    
    func getCategoryNames() {
        
        print("In catNames")
        print(self.categories.count)
        
        for x in self.categories {
            print("In for loop")
            let query = PFQuery(className: "Category")
            query.getObjectInBackground(withId: x) { (category, error) in
              if error != nil && category != nil {
                print(category!["name"] as! String)
                self.categoryNames.append(category!["name"] as! String)
              } else {
                print(error)
              }
            }
        }
    }
    
    
    func getCategories() {
        // Get Category objectIds
        let query = PFQuery(className: "Inventory")
        query.getObjectInBackground(withId: inventoryID) { (inventory, error) in
          if error == nil && inventory != nil {

            self.categories = inventory!["categories"] as! [String]
            print("in getCat")
            print(self.categories.count)
            if inventory!["itemList"] != nil {
                self.items = inventory!["items"] as! [String]
            } else {
                self.items = []
            }
          } else {
            print(error)
          }
        }
        print("End of getCat")
        print(self.categories.count)
    }

    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCategory" {
            let navVCs = segue.destination as! UINavigationController
            let destinationVC = navVCs.viewControllers[0] as! AddCategoryViewController
            destinationVC.inventoryID = inventoryID
        } else if segue.identifier == "addItem" {
            let navVCs = segue.destination as! UINavigationController
            let destinationVC = navVCs.viewControllers[0] as! AddItemViewController
            destinationVC.inventoryID = inventoryID
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == 0{
//                return CGSize(width: 50, height: 33)
//            } else {
//                return CGSize(width: 115, height: 33)
//            }
//        }
    
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
                
                cell.addCategoryButton.layer.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.addCategoryButton.layer.borderWidth = 2.0
                cell.addCategoryButton.layer.cornerRadius = 15
                
                return cell
                
            } else{
                let cell = categoryPickCollection.dequeueReusableCell(withReuseIdentifier: categoryCollectionViewIdentifier, for: indexPath) as! HorizCategoryCollectionViewCell
                
                
                cell.categoryLabel.layer.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.categoryLabel.layer.borderWidth = 2.0
                cell.categoryLabel.layer.cornerRadius = 15
                let title = categoryNames[indexPath.row - 1]
                cell.categoryLabel.text = title
                
                return cell
            }
            
        }
        else{
            
            let cell = itemCollection.dequeueReusableCell(withReuseIdentifier: itemCollectionViewIdentifier, for: indexPath) as! InventoryCollectionViewCell
            
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
                print(error)
              }
            }
            
//            cell.itemNameLabel.text = "Garlic"
//            cell.itemNumberLabel.text = String(2)
            
            
            cell.layer.cornerRadius = 15
            //cell.layer.borderWidth = 1.0
            cell.layer.backgroundColor = #colorLiteral(red: 1, green: 0.5132452846, blue: 0.6042660475, alpha: 0.1098958795)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.categoryPickCollection{
            
            let selectedCat = categories[indexPath.row]

            let query = PFQuery(className: "Category")
            query.getObjectInBackground(withId: selectedCat) { (category, error) in
              if error == nil && category != nil {
                self.items = category!["items"] as! [String]
                collectionView.reloadData()
              } else {
                print(error)
              }
            }
            
        } else {
            performSegue(withIdentifier: "showItemDetails", sender: nil)
        }
        
      }
    
    
}

