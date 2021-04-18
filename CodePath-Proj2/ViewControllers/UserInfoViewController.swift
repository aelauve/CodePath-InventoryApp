//
//  UserInfoViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 4/2/21.
//

import UIKit
import Parse

class UserInfoViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //let dataSource = ["View Controller 1", "View Controller 2", "View Controller 3", "View Controller 4"]
    var dataSource: [[String]] = [[String]]()
    var currentViewControllerIndex = 0
    
    var firstName: String?
    var lastName: String?
    var inventoryList: [String]?
    
    let myGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        getUserInfo()
        // Do any additional setup after loading the view.
    }
    
    func getUserInfo(){
        
        //Populate user info
        let user = PFUser.current()
        
        firstName = user!["firstName"] as? String
        lastName = user!["lastName"] as? String
        inventoryList = user!["inventories"] as? [String]
        nameLabel.text = firstName! + " " + lastName!
        
        
        for invID in inventoryList!{
            self.myGroup.enter()
            let query = PFQuery(className: "Inventory")
            query.getObjectInBackground(withId: invID) { (inventory, error) in
              if error == nil && inventory != nil {

                let invName = inventory!["name"] as! String
                let createdAt = "April 18, 2021"
                
                if inventory!["ownedBy"] as? [String] != nil{
                    var userString = ""
                    var index = 0
                    
                    for userID in inventory!["ownedBy"] as! [String]{
                        
                        let innerGroup = DispatchGroup()
                        
                        innerGroup.enter()
                        let query = PFUser.query()
                        query!.getObjectInBackground(withId: userID) { (user, error) in
                          if error == nil && user != nil {
                            
                            print("User Name: \(user!["firstName"])")
                            
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
                            self.dataSource.append([invID, invName, userString, createdAt])
                            //print(self.dataSource[index])
                            index += 1
                        }
                        
                    }
                } else {
                    self.dataSource.append([invID, invName, " ", createdAt])
                }
              } else {
                print("Info load error")
              }
                self.myGroup.leave()
            }
        }
        
        self.myGroup.notify(queue: .main){
            self.configurePageViewController()
        }
        print(dataSource)
        let date = Date.init()
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        print(dateFormat.string(from: date))
        
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
