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
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var lightColor: UIColor = UIColor(named: "GreenLight")!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Load colors
        getColorScheme()
        
        // Load inventories
        let user = PFUser.current()
        invObjects = user!["inventories"] as! [String]
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Load colors
        getColorScheme()
        
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
    

    @IBAction func addInventory(_ sender: Any) {
        self.performSegue(withIdentifier: "addInventory", sender: nil)
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
//        let user = PFUser.current()
//        print(user!["firstName"])
        PFUser.logOut()
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
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

        cell.inventoryLabel.backgroundColor = self.regColor
        cell.inventoryLabel.layer.cornerRadius = 10
        //cell.inventoryLabel.layer.borderColor = #colorLiteral(red: 0.852301836, green: 0.4426146448, blue: 0.608592689, alpha: 1)

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
            destinationVC.regColor = self.regColor
            destinationVC.lightColor = self.lightColor
        }
        if segue.identifier == "addInventory"{
            let navVC = segue.destination as! UINavigationController
            let destinationVC = navVC.viewControllers[0] as! AddInventoryViewController
            destinationVC.regColor = self.regColor
            destinationVC.lightColor = self.lightColor
        }
        
    }

}
