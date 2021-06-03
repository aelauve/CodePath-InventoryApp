//
//  ShoppingListViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 2/21/21.
//

import UIKit
import Parse

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var finishShoppingButton: UIButton!
    @IBOutlet weak var addItemButton: UIBarButtonItem!
    var itemList: [String] = []
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var lightColor: UIColor = UIColor(named: "GreenLight")!
    var user = PFUser.current()
    //var isSelected: Int = -1
    var isSelected = [Int](repeating: 0, count: 75)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getColorScheme()
        
        addItemButton.tintColor = regColor
        finishShoppingButton.backgroundColor = regColor
        finishShoppingButton.layer.cornerRadius = 5
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.estimatedRowHeight = 0
        
        getItems { (valuesINeed , error) in
            
            if let error = error {
                print(error)
            }
            self.itemList = valuesINeed!
            self.listTableView.reloadData()
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle {
        return .none
    }
    
    func getColorScheme(){
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
    
    func getItems(completionHandler : @escaping (_ arrayOfItems : [String]? , _ error : Error?) -> () ) {
        var finalArray: [String] = []
        
        let user = PFUser.current()
        let query = PFQuery(className: "ShoppingList")
        let list: String = user!["shoppingList"] as! String
        query.getObjectInBackground(withId: list) { (list, error) in
            
            if let error = error {
                completionHandler(nil , error)
            }
            guard let list = list else { return }
            finalArray = list["itemsToShop"]! as! [String]
            completionHandler(finalArray, nil)

        }
    }
    
    @IBAction func addToList(_ sender: UIBarButtonItem) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PopoverViewController")
            vc.modalPresentationStyle = .popover
            let popover: UIPopoverPresentationController = vc.popoverPresentationController!
            popover.barButtonItem = sender
            present(vc, animated: true, completion:nil)
        
    }
    
    @IBAction func finishShopping(_ sender: Any) {
        
        // Update in Parse
        
        let user = PFUser.current()
        let query = PFQuery(className:"ShoppingList")
        query.getObjectInBackground(withId: user!["shoppingList"] as! String) { (parseObject, error) in
          if error != nil {
            print(error)
          } else if parseObject != nil {
            parseObject!["itemsToShop"] = []
            parseObject!.saveInBackground()
          }
        }
        
        itemList = []
        listTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //self.isSelected = indexPath.row
        if isSelected[indexPath.row] == 0 {
            isSelected[indexPath.row] = 1
        }
        else {
            isSelected[indexPath.row] = 0
        }

        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listItemCell", for: indexPath) as! ShopListItemsTableViewCell
        
        cell.listItemName.text = itemList[indexPath.row]
        cell.listItemImage.layer.borderWidth = 2.0
        cell.listItemImage.layer.borderColor = regColor.cgColor
        
        if isSelected[indexPath.row] == 1 {
            cell.backgroundColor = lightColor
            cell.listItemImage.tintColor = regColor
            cell.listItemImage.image = UIImage(systemName: "checkmark.circle")
            cell.listItemImage.layer.borderWidth = 3.0
            cell.layer.opacity = 0.5
        } else {
            cell.listItemImage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.listItemImage.image = nil
            cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        cell.listItemImage.layer.cornerRadius = (cell.listItemImage?.frame.size.width ?? 0.0) / 2
        
        cell.listItemImage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //cell.checkOffImage.layer.cornerRadius = (cell.listItemImage?.frame.size.width ?? 0.0) / 2
        
        
        return cell
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
