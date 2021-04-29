//
//  DataViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 4/2/21.
//

import UIKit
import Parse

class DataViewController: UIViewController {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var invNameLabel: UILabel!
    @IBOutlet weak var invIDLabel: UILabel!
    @IBOutlet weak var sharedWithLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    
    var index: Int?
    var nameLabel: String?
    var idLabel: String?
    var sharedWith: String?
    var createdAt: String?
    
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var lightColor: UIColor = UIColor(named: "GreenLight")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getColorInfo()
        
        outerView.layer.cornerRadius = 20
        outerView.backgroundColor = regColor
        //outerView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        outerView.layer.opacity = 0.5
        
        invNameLabel.text = nameLabel
        //invNameLabel.sizeToFit()
        
        invIDLabel.text = idLabel
        //invIDLabel.sizeToFit()
        
        sharedWithLabel.text = sharedWith
        //sharedWithLabel.sizeToFit()
        
        createdLabel.text = createdAt
        //createdLabel.sizeToFit()

        // Do any additional setup after loading the view.
    }
    
    func getColorInfo(){
        
        let user = PFUser.current()
        
        let color: String = user!["colorPalette"] as! String
        switch color {
        case "Green":
            self.regColor = UIColor(named: "GreenReg")!
            self.lightColor = UIColor(named: "GreenLight")!
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
