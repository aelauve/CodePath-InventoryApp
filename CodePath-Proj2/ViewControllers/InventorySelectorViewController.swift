//
//  InventorySelectorViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 3/16/21.
//

import UIKit
import Parse

class InventorySelectorViewController: UITableViewController {

    var invObjects: [String] = [String]()
    //var invNames: [String] = [String]()
    var invSelected: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load inventories
        let user = PFUser.current()
        invObjects = user!["inventories"] as! [String]
        print("invObjects")
        
//        for x in user!["inventories"]\{
//            invObjects.append(x)
//        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
//    @IBAction func onAddNew(_ sender: Any) {
//        print("Link a new inventory")
//        
//    }
    

    @IBAction func addInventory(_ sender: Any) {
        self.performSegue(withIdentifier: "addInventory", sender: nil)
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return invObjects.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventorySelectorCell", for: indexPath) as! InventorySelectorTableViewCell

        cell.inventoryLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 0.5132452846, blue: 0.6042660475, alpha: 1)
        cell.inventoryLabel.layer.cornerRadius = 10
        cell.inventoryLabel.layer.borderColor = #colorLiteral(red: 0.852301836, green: 0.4426146448, blue: 0.608592689, alpha: 1)

        var inv: String = invObjects[indexPath.row]
        
        let query = PFQuery(className: "Inventory")
        query.getObjectInBackground(withId: inv) { (inventory, error) in
          if error == nil && inventory != nil {
            cell.inventoryLabel.text = inventory!["name"] as! String
          } else {
            print(error)
          }
        }
        
        //cell.inventorySelectButton.setTitle(invName, for: .normal)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        invSelected = invObjects[indexPath.row]
        
        self.performSegue(withIdentifier:"invSelected", sender: nil)
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        if segue.identifier == "invSelected"{
            let barVCs = segue.destination as! UITabBarController
            let navVCs = barVCs.viewControllers?[0] as! UINavigationController
            let destinationVC = navVCs.viewControllers[0] as! InventoryViewController
            destinationVC.inventoryID = invSelected
        }
        
    }

}
