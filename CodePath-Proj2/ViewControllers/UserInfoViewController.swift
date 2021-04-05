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
    var dataSource: [[String]] = [ ["0001", "Personal", " ", "January 1, 2021"], ["0002", "Family", "Mom, Dad, Brother, Sister", "February 1, 2021"], ["0003", "Roomies", "Zawad, Enrique, Sara", "March 1, 2021"], ["0004", "Work", "Coworkers", "April 1, 2021"] ]
    var currentViewControllerIndex = 0
    
    var firstName: String?
    var lastName: String?
    var inventoryList: [Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUserInfo()
        
        configurePageViewController()
        // Do any additional setup after loading the view.
    }
    
    func getUserInfo(){
        
        //Populate user info
        let user = PFUser.current()
        
        firstName = user!["firstName"] as? String
        lastName = user!["lastName"] as? String
        
        nameLabel.text = firstName! + " " + lastName!
        
        
        //Populate data source
//        let query = PFQuery(className: "Inventory")
//        query.includeKeys(["objectId", "name", "ownedBy", "createdAt"])
//        query.whereKey("ownedBy", contains: user!["objectId"] as! String) //Not sure if this actually works
//
//        query.findObjectsInBackground { (inventories, error) in
//            if inventories != nil {
//                print(inventories) //To be replaced later
////                for i in inventories! {
////                    self.dataSource.append(i)
////                }
//            } else {
//                print("Error: \(error?.localizedDescription)")
//            }
//        }
        
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
        if index >= dataSource.count || dataSource.count == 0 {
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
