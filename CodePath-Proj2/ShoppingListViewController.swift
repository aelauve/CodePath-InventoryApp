//
//  ShoppingListViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 2/21/21.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.estimatedRowHeight = 0
        
        listTableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Function for what to do when user taps a cell
        //May not be needed, just placed sample code in case
        print("you tapped me")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listItemCell", for: indexPath) as! ShopListItemsTableViewCell
        
        cell.listItemImage.layer.borderWidth = 1.0
        cell.listItemImage.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cell.listItemImage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.listItemImage.layer.cornerRadius = (cell.listItemImage?.frame.size.width ?? 0.0) / 2
        
        
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
