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

* The user can add items manually or through barcode scanning
* The user can categorize items to make the inventory more organized 
* The user can register an account 
* The user can log in to their account and have all the previous information stored

**Optional Nice-to-have Stories**

* The user can can share an inventory with multiple family members, each having their own personal inventory and one shared inventory 
* The user will be able to chat with the other members who have access to the shared inventory
* The user can make price comparison while adding items to the shopping list to search for the website with the lowest price

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
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
