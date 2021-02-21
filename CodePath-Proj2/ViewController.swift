//
//  ViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 2/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    var categories = ["All", "Meat", "Dairy", "Cleaning", "Misc"]

    @IBOutlet weak var categoryPickCollection: UICollectionView!
    @IBOutlet weak var itemCollection: UICollectionView!
    let categoryCollectionViewIdentifier = "horizCategoryCell"
    let itemCollectionViewIdentifier = "inventoryItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(categoryPickCollection)
//        self.view.addSubview(itemCollection)
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if collectionView == self.categoryPickCollection{
            
            return categories.count
        }
        else{
            return 21
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.categoryPickCollection{
            
            let cell = categoryPickCollection.dequeueReusableCell(withReuseIdentifier: categoryCollectionViewIdentifier, for: indexPath) as! HorizCategoryCollectionViewCell
            
            
            cell.categoryButton.layer.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            cell.categoryButton.layer.borderWidth = 2.0
            cell.categoryButton.layer.cornerRadius = 15
            let title = categories[indexPath.row]
            cell.categoryButton.setTitle(title, for: .normal)
            return cell
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
    
    
}

