# Inventory App

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Our Inventory App seeks to provide an exhaustive databse for our user's belongings, ranging from their groceries, electronics, clothes, etc.
Users will be able to keep track of their personal inventories, as well as shared inventories for group living situations such as families or roomates.
The app will allow users to add items in several ways: manually type in the item information, scan a barcode to auto-populate the data, or check off an item in a shopping list to update the count of an item. Users will also be able to remove items as needed. There will be a shopping list feature in which users may check off items as they shop in store, updating their inventory database with each item.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Database, Item Tracking
- **Mobile:** Mobile first experience, uses camera
- **Story:** Allows users to organize their groceries and belongings, enabling them ease of access and a streamlined shopping procedure.
- **Market:** Anyone that appreciates organization for their items and groceries would appreciate this app. Ability to view, track, and update their inventory as needed allows users to stay organized as well as share a communication platform for necessites across a household.
- **Habit:** Users will likely open the app at least once a week, if not more. The app will store household items as well as groceries, which are typically shopped for at least once a week or every two weeks. Very habit forming!
- **Scope:** The app will start out as just an inventory tracker and associated shopping list. However, it has the potential to support in-app messaging between members of a shared inventory as well as in-app shopping, possibly through Food/Grocery Delivery APIs.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] The user can add items manually
- [x] The user can add categories manually
- [ ] The user can categorize items to make the inventory more organized 
- [x] The user can register an account 
- [x] The user can log in to their account and have all the previous information stored

**Optional Nice-to-have Stories**

- [ ] The user can add items manually or through barcode scanning
- [x] The user can can share an inventory with multiple family members, each having their own personal inventory and one shared inventory 
- [ ] The user will be able to chat with the other members who have access to the shared inventory
- [ ] The user can make price comparison while adding items to the shopping list to search for the website with the lowest price

### 2. Screen Archetypes

* Login
   * Users may sign-up for a new account
   * Users can login to an existing account
* Inventory Selector
   * User may choose which inventory they wish to view, update, or shop for
* Inventory
   * User may select a category to filter the items in their inventory
   * User can view a "feed" of inventory items related to the selected category
   * User may add a new item to their inventory
* Item Details
   * User may view information related to the selected item
   * User may add the item to their shopping list
   * User may update the count of the item
   * User may delete the item from their inventory, updating the database and returning them to the inventory screen
* Add Item
   * User will be prompted to scan a barcode or may opt to enter the item manually
   * User can manually input the required fields for the item
   * User can click a button to add the item to the inventory, which will update the database and take them to the inventory screen
* Shopping List
   * User may check off each item that has been shopped for, updating the database and clearing the item from the list
   * User may add a new item to their shopping list

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Inventory
* Shopping List
* Barcode Scanner

**Flow Navigation** (Screen to Screen)

* Login
   * Inventory Selector
* Inventory Selector
   * Inventory
* Inventory
   * Add Item
   * Item Details
* Item Details
   * Inventory
* Add Item
   * Inventory
   * Barcode Scan
* Barcode Scan
   * Add Item 
   * Inventory
* Shopping List
   * Shopping List Add Item
* Shopping List Add Item
   * Shopping List 

## Wireframes
[Add picture of your hand sketched wireframes in this section]
![](https://i.imgur.com/f3jRk14.jpg)


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype
<img src='http://g.recordit.co/YsKwo49en8.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Schema 

### Models

User

| Property      | Type                           | Description                                  |
| ------------- | ------------------------------ | -------------------------------------------- |
| username      | String                         | unique ID for the user                       |
| userPassword  | String                         | password for user login                      |
| inventoryID   | Array of pointers to Inventory | inventory IDs associated with Inventory data |
| userFirstName | String                         | user's first name                            |
| userLastName  | String                         | user's last name                             |
| userEmail     | String                         | user's e-mail address                        |

Inventory

| Property    | Type                          | Description                               |
| ----------- | ----------------------------- | ----------------------------------------  |
| inventoryID | Number                        | unique ID for the inventory               |
| name        | String                        | name for inventory (Personal, Family, etc)|
| categories  | Array of pointers to Category | unique IDs associated with Category data  |
| ownedBy     | Array of pointers to User     | unique IDs associated with User data      |

Category

| Property     | Type                      | Description                          |
| ------------ | ------------------------- | ------------------------------------ |
| categoryName | String                    | unique ID for the category           |
| categoryIcon | File                      | picture/icon to represent category   |
| itemList     | Array of pointers to Item | unique IDs associated with Item data |

Item

| Property     | Type                | Description                        |
| ------------ | ------------------- | ---------------------------------- |
| itemName     | String              | unique ID for the item             |
| itemCategory | Pointer to Category | category the item belongs to       |
| itemIcon     | File                | picture/icon to represent the item |
| expiration   | Date                | date of item expiration, if any    |
| itemCount    | Number              | number of items in the inventory   |
| notes        | String              | optional user notes for the item   |

ShoppingList

| Property    | Type                      | Description                               |
| ----------- | ------------------------- | ----------------------------------------- |
| inventoryID | Pointer to Inventory      | inventory that the list is associate with |
| itemList    | Array of pointers to Item | list of items to shop for                 |

### Networking

List of network requests by screen

* Login
   * (Read/GET) Query username and password for login authentication

          let username = userNameField.text!
          let password = passwordField.text!

          PFUser.logInWithUsername(inBackground:username, password: password) { (user, error) in
            if user != nil {
              self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
              print("Error: \(String(describing: error?.localizedDescription))")
   
   * (Create/POST) Create a new user
  
          let user = PFUser()
          user.username = userNameField.text
          user.password = passwordField.text
          user.firstName = firstNameField.text
          user.lastName = lastNameField.text
          user.email = emailField.text

          user.signUpInBackground { (success, error) in
              if success {
                  self.performSegue(withIdentifier: "loginSegue", sender: nil)
              } else {
                  print("Error: \(String(describing: error?.localizedDescription))")
              }
          }
        
* Inventory Selector
   * (Read/GET) Query user's list of inventories

          let user = PFUser()
          let inventoryIDArray = user.inventories

          let inventoryListArray = []

          for inventoryID in inventoryIDArray {
            let query = PFQuery(className: "Inventory")
            query.whereKey("ownedBy", containedIn: user)
            query.findObjectsInBackground { ( ... *To be continued*
          }

   * (Update/PUT) Update inventory list with new Inventory

          let user = PFUser.current()
          let newInventory = PFObject(className: "Inventory")
          newInventory[inventoryID] = //random number
          newInventory[categories] = []
          newInventory[ownedBy] = [user]

          newInventory.saveInBackground { (success, error) in
              if success {
                  print("Inventory created!")
                  self.dismiss(animated: true, completion: nil)
              } else {
                  print("Error: \(error?.localizedDescription)")
              }
          }

          user[inventoryID].append(newInventory) //Not sure if this works

          user.saveInBackground { (success, error) in
              if success {
                  print("Inventory added!")
                  self.dismiss(animated: true, completion: nil)
              } else {
                  print("Error: \(error?.localizedDescription)")
              }
          }

  * (Update/PUT) Link existing inventory

* Inventory
   * (Read/GET) Query inventory's list of categories

          let query = PFQuery(className:"Inventory")
          query.findObjectsInBackground { (categories: [PFObject]?, error: Error?) in
            if let error = error {
              print(error.localizedDescription)
            } else {
              print("Successfully retrieved \(categories.count) categories.")
              //TODO: Do something with the categories
              }
            }

   * (Read/GET) Query inventory's list of items

          let query = PFQuery(className:"Inventory")
          query.findObjectsInBackground { (items: [PFObject]?, error: Error?) in
            if let error = error {
              print(error.localizedDescription)
            } else {
              print("Successfully retrieved \(items.count) items.")
              //TODO: Do something with the items
              //      (Will only display when "All" is selected)
              }
            }

   * (Read/GET) Query each category's list of items

          //Previously defined variable chosenCategory
          let query = PFQuery(className:"Category")
          query.whereKey("categoryName", equalTo: chosenCategory)
          query.findObjectsInBackground { (items: [PFObject]?, error: Error?) in
            if let error = error {
              print(error.localizedDescription)
            } else {
              print("Successfully retrieved \(items.count) items.")
              //TODO: Do something with the items
              }
            }

   * (Create/POST) Create a new category
* Item Details
   * (Read/GET) Query item's data (name, count, expiration, notes, etc)
   * (Update/PUT) Update item picture
   * (Update/PUT) Update item count
   * (Delete) Delete item from database
* Add Item
   * (Create/POST) Create a new item
* Shopping List
   *  (Create/POST) Create a new shopping list item
   *  (Update/PUT) Update item count
   *  (Delete) Delete item from shopping list

## Updates

<img src='http://g.recordit.co/a4ZTgJ1Po5.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='http://g.recordit.co/KM41pUqNkC.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

- Fixed a login bug
- Added special alerts on sign up and first login
- Added networking to store and display actual user data
<img src='http://g.recordit.co/fWvaXlvnCv.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='http://g.recordit.co/epycgDBe9i.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
