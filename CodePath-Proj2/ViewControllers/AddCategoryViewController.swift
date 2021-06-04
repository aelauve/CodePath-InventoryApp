//
//  AddCategoryViewController.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 3/17/21.
//

import UIKit
import Parse

class AddCategoryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var defaultIconImage: UIImageView!
    @IBOutlet weak var chooseImageButton: UIButton!
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var addCategoryButton: UIButton!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.isUserInteractionEnabled = true
        }
    }
    
    var inventoryID: String = ""
    var regColor: UIColor = UIColor(named: "GreenReg")!
    var lightColor: UIColor = UIColor(named: "GreenLight")!
    
    var instanceOfIVC: InventoryViewController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCategoryButton.backgroundColor = regColor
        //addCategoryButton.layer.borderWidth = 2.0
        addCategoryButton.layer.cornerRadius = 10
        
        imageView.tintColor = lightColor

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSelectImage(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 120, height: 120)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        print("didFinishPicking: ", imageView.image)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onChooseImage(_ sender: Any) {
    }
    
    @IBAction func onAddCategory(_ sender: Any) {
        
        // If input is blank, show error message
        if categoryNameTextField.text == ""{
            let alert = UIAlertController(title: "Uh Oh!", message: "Category Name must be filled in.", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            {
                (UIAlertAction) -> Void in
            }
            alert.addAction(alertAction)
            present(alert, animated: true)
            {
                () -> Void in
            }
        } else {
            
            var newCat = PFObject(className:"Category")
            newCat["categoryName"] = categoryNameTextField.text
            newCat["itemList"] = []
            
            print("onAddCat: ", imageView.image)
            let imageData = imageView.image!.pngData()
            let file = PFFileObject(name: "image.png", data: imageData!)
            newCat["icon"] = file
            
            newCat.saveInBackground { (success, error) in
                if success {
                    let catObjID = newCat.objectId!
                    
                    var query = PFQuery(className:"Inventory")
                    
                    query.getObjectInBackground(withId: self.inventoryID) { (inventory, error) in
                        if error == nil && inventory != nil {
                            if inventory!["categories"] == nil {
                                inventory!["categories"] = [catObjID]
                            } else {
                                var invCats: [String] = inventory!["categories"] as! [String]
                                invCats.append(catObjID)
                                inventory!["categories"] = invCats
                            }
                            
                            inventory!.saveInBackground() { (success, error) in
                                if success {
                                    self.dismiss(animated: true, completion: {
                                        DispatchQueue.main.async {
                                            //self.instanceOfIVC.itemCollection.reloadData()
                                            self.instanceOfIVC.viewDidLoad()
                                        }
                                    })
                                } else {
                                    print("Inventory save error")
                                    print("Error: \(error?.localizedDescription)")
                                }
                            }
                        
                      } else {
                        print("nil inventory")
                      }
                    }
                    
                } else {
                    print("Category save error")
                    print("Error: \(error?.localizedDescription)")
                }
            }
            
            
            //Add category to user database
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
