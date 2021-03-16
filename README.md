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
- **Category:**
- **Mobile:**
- **Story:**
- **Market:**
- **Habit:**
- **Scope:**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [fill in your required user stories here]
* ...

**Optional Nice-to-have Stories**

* [fill in your required user stories here]
* ...

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
* Shopping List

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
