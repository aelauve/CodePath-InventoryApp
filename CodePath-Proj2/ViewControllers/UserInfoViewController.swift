//
//  UserInfoViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 4/2/21.
//

import UIKit
import Parse

class UserInfoViewController: UIViewController, ModalTransitionListener {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userProfileView: UIView!
    @IBOutlet weak var settingsButton: UIButton!
    
    var dataSource: [[String]] = [[String]]()
    var currentViewControllerIndex = 0
    
    var firstName: String?
    var lastName: String?
    var inventoryList: [String]?
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var lightColor: UIColor = UIColor(named: "GreenLight")!
    var chosenColor: String = "Green"
    var imageFile: PFFileObject!
    var url: URL!
    let user = PFUser.current()
    var boolean = false
    
    let myGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //viewDidAppear(true)
        ModalTransitionMediator.instance.setListener(listener: self)

        getUserInfo()
        
        configurePageViewController()
        
        userProfileView.backgroundColor = regColor
        settingsButton.backgroundColor = lightColor
        settingsButton.layer.cornerRadius = 15
        
        //visual design of profile picture
        userImageView.layer.borderWidth = 1.0
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        userImageView.clipsToBounds = true
        
        
        if((user?["profileImage"]) != nil)
        {
            userImageView.af_setImage(withURL: url)
            userImageView.layer.borderWidth = 1.0
            userImageView.layer.masksToBounds = false
            userImageView.layer.borderColor = UIColor.white.cgColor
            userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
            userImageView.clipsToBounds = true
        }
        else{
            userImageView.image = UIImage(systemName: "person.fill")
            userImageView.layer.borderWidth = 1.0
            userImageView.layer.masksToBounds = false
            userImageView.layer.borderColor = UIColor.white.cgColor
            userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
            userImageView.clipsToBounds = true
            
        }
    }
    

//
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let dataView = DataViewController()
        
        dataView.getColorInfo()



//        let color: String = user!["colorPalette"] as! String
//        getColorScheme(color: color)
//
//        userProfileView.backgroundColor = regColor
//        settingsButton.backgroundColor = lightColor
//        settingsButton.layer.cornerRadius = 15
    }
    
    //required delegate func
    func popoverDismissed() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        self.boolean = true
//        currentViewControllerIndex += 1
        self.viewDidLoad()
        
        
    }
    
    func getColorScheme(color: String){

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
    
    func getUserInfo(){
        
        //Populate user info
        
        firstName = user!["firstName"] as? String
        lastName = user!["lastName"] as? String
        inventoryList = user!["inventories"] as? [String]
        nameLabel.text = firstName! + " " + lastName!
        
        if user!["profileImage"] != nil {
            imageFile = user!["profileImage"] as? PFFileObject
            let urlString = imageFile.url!
            url = URL(string: urlString)!
        }
        
        
        let color: String = user!["colorPalette"] as! String
        getColorScheme(color: color)
        
        
        for invID in inventoryList!{
            self.myGroup.enter()
            let query = PFQuery(className: "Inventory")
            query.getObjectInBackground(withId: invID) { (inventory, error) in
              if error == nil && inventory != nil {

                let invName = inventory!["name"] as! String
//                let createdAt = "April 18, 2021"
                let createdAt =  inventory?.createdAt!
                let dateFormat = DateFormatter()
                dateFormat.dateStyle = .medium
                let createdDate = dateFormat.string(from: createdAt!)
            
                if inventory!["ownedBy"] as? [String] != nil{
                    var userString = ""
                    var index = 0
                    
                    for userID in inventory!["ownedBy"] as! [String]{
                        
                        let innerGroup = DispatchGroup()
                        
                        innerGroup.enter()
                        let query = PFUser.query()
                        query!.getObjectInBackground(withId: userID) { (user, error) in
                          if error == nil && user != nil {
                            
                            //print("User Name: \(user!["firstName"])")
                            
                            if index == inventory!.accessibilityElementCount()-1{
                                userString += user!["firstName"] as! String
                            } else {
                                userString += user!["firstName"] as! String + ", "
                            }
                            
                          } else {
                            print("Could not load user")
                          }
                        }
                        innerGroup.leave()
                        
                        innerGroup.notify(queue: .main){
                            self.dataSource.append([invID, invName, userString, createdDate])
                            //print(self.dataSource[index])
                            index += 1
                        }
                        
                    }
                } else {
                    self.dataSource.append([invID, invName, " ", createdDate])
                }
              } else {
                print("Info load error")
              }
                self.myGroup.leave()
            }
        }
        
        self.myGroup.notify(queue: .main){
            if (self.boolean == false){
                self.configurePageViewController()
            }
            //self.configurePageViewController()
        }
        //print(dataSource)
    }
    
    @IBAction func onSettings(_ sender: Any) {
        performSegue(withIdentifier: "goToSettings", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSettings" {
            let navVCs = segue.destination as! UINavigationController
            let destinationVC = navVCs.viewControllers[0] as! SettingsViewController
            destinationVC.regColor = self.regColor
        }
    }
    
    
    func configurePageViewController() {
        
        // Get reference to custom PageViewController
        guard let pageViewContoller = storyboard?.instantiateViewController(identifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else {
            return
        }
        
        pageViewContoller.delegate = self
        pageViewContoller.dataSource = self
        
        addChild(pageViewContoller)
        pageViewContoller.didMove(toParent: self)
        
        
        //Place PageController's View into contentView container
        pageViewContoller.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pageViewContoller.view)
        
        //Add constraints
        let views: [String: Any] = ["pageView": pageViewContoller.view]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
                                                                  options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                  metrics: nil,
                                                                  views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
                                                                  options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                  metrics: nil,
                                                                  views: views))
        
        //Get starting ViewController
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else {
            return
        }
        
        pageViewContoller.setViewControllers([startingViewController], direction: .forward, animated: true)
        
    }
    
    //Instantiate new instance of DataVC, assign index, and return
    func detailViewControllerAt(index: Int) -> DataViewController? {
        
        //Error checking
        if index >= dataSource.count || dataSource.count == 0 || dataSource[index] == []{
            return nil
        }
        
        
        guard let dataViewController = storyboard?.instantiateViewController(identifier: String(describing: DataViewController.self)) as? DataViewController else {
            return nil
        }
        
        
        dataViewController.index = index
        dataViewController.idLabel = dataSource[index][0]
        dataViewController.nameLabel = dataSource[index][1]
        dataViewController.sharedWith = dataSource[index][2]
        dataViewController.createdAt = dataSource[index][3]
        
        //dataViewController.createdAt = dataSource[index]
        
        return dataViewController
    }

    

}

extension UserInfoViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? DataViewController
        
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        
        currentViewControllerIndex = currentIndex
        
        if currentIndex == 0 {
            return nil
        }
        
        currentIndex -= 1
        
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? DataViewController
        
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        
        if currentIndex == dataSource.count {
            return nil
        }
        
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        
        return detailViewControllerAt(index: currentIndex)
        
    }
}
