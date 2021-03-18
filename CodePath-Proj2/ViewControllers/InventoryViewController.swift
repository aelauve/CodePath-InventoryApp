//
//  ViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 2/20/21.
//

import UIKit

class InventoryViewController: UIViewController {
    
    var categories = ["All", "Meat", "Dairy", "Cleaning", "Misc"]

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var categoryPickCollection: UICollectionView!
    @IBOutlet weak var itemCollection: UICollectionView!
    
    let addCategoryCollectionViewIdentifier = "addCategoryCell"
    let categoryCollectionViewIdentifier = "horizCategoryCell"
    let itemCollectionViewIdentifier = "inventoryItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(categoryPickCollection)
//        self.view.addSubview(itemCollection)
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
            return 21
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
                
                
                cell.categoryButton.layer.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.categoryButton.layer.borderWidth = 2.0
                cell.categoryButton.layer.cornerRadius = 15
                let title = categories[indexPath.row - 1]
                cell.categoryButton.setTitle(title, for: .normal)
                
                return cell
            }
            
        }
        else{
            
            let cell = itemCollection.dequeueReusableCell(withReuseIdentifier: itemCollectionViewIdentifier, for: indexPath) as! InventoryCollectionViewCell
            
            cell.itemImage.layer.borderWidth = 1.0
            cell.itemImage.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            cell.itemImage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.itemImage.layer.cornerRadius = (cell.itemImage?.frame.size.width ?? 0.0) / 2
            
            cell.itemNameLabel.text = "Garlic"
            cell.itemNumberLabel.text = String(2)
            
            
            cell.layer.cornerRadius = 15
            //cell.layer.borderWidth = 1.0
            cell.layer.backgroundColor = #colorLiteral(red: 1, green: 0.5132452846, blue: 0.6042660475, alpha: 0.1098958795)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("item at \(indexPath.section)/\(indexPath.item) tapped")
        performSegue(withIdentifier: "showItemDetails", sender: nil)
      }
    
    
}

