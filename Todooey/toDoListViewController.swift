//
//  ViewController.swift
//  Todooey
//
//  Created by Kyle Patterson on 2019-01-16.
//  Copyright © 2019 sun wolf. All rights reserved.
//

import UIKit
import CoreData

class LoDoListViewController: UITableViewController, UISearchBarDelegate {
    
    
   var itemArray = [Item]()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    var defaults = UserDefaults.standard
    
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
          let dataFilePAth = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
        
    
        print(dataFilePAth!)
        
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = items
        
        }
    
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
     
        return cell
        }
    
    
    //Mark = TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
       // context.delete(itemArray[indexPath.row])
         //itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
     
        }
    
    // add new item
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "alert", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what happen when add item clicked
            self.saveItems()
            
         
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
          
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create newItem"
           textField = alertTextField
        
        
        }
        
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
    
    }
    
    func saveItems() {
      
        
        do {
          try context.save()
            
        } catch{
            print("error saving context \(error)")
            
            
        }
        self.tableView.reloadData()
        
    }
    
    func loadItems( with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@ ", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
    
  
        do{
     itemArray = try context.fetch(request)
        } catch {
            print("error fetching data from context \(error)")
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
     
        
        
      let predicate = NSPredicate(format: "title CONTAINS %@[cd] ", searchBar.text!)
        
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
       
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            
            DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
            
            }
        
        }
    
    }
    
 
}


