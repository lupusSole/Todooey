//
//  ViewController.swift
//  Todooey
//
//  Created by Kyle Patterson on 2019-01-16.
//  Copyright © 2019 sun wolf. All rights reserved.
//

import UIKit
import RealmSwift

class LoDoListViewController: UITableViewController, UISearchBarDelegate {
    
    
    var  toDoItems: Results <Item>?
    let realm =  try! Realm()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "no  items added "
        }
        
      
     
        return cell
        }
    
    
    //Mark = TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let item = toDoItems?[indexPath.row]{
            do{
            try realm.write {
              item.done = !item.done
            }
            }catch {
                print("Error saving done status \(error)")
            }
        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
     
        
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "alert", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what happen when add item clicked
         
            
            if let currentCategory = self.selectedCategory{
                
                do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
               
                } catch {
                    print("error saving new items \(error)")
                }
            }
            
       self.tableView.reloadData()
          
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create newItem"
           textField = alertTextField
        
        
        }
        
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
    
    }
    

    
    func loadItems() {

       toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItems = toDoItems?.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()

    }
//
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()


            DispatchQueue.main.async {
                    searchBar.resignFirstResponder()

            }

        }

    }

 
}


