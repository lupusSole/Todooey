//
//  ViewController.swift
//  Todooey
//
//  Created by Kyle Patterson on 2019-01-16.
//  Copyright © 2019 sun wolf. All rights reserved.
//

import UIKit

class LoDoListViewController: UITableViewController {
    
    
   var itemArray = [Item]()
    var defaults = UserDefaults.standard
        let dataFilePAth = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        print(dataFilePAth!)
        
       
        
        loadItems()
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
            
            let newItem = Item()
            newItem.title = textField.text!
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
        let encoder = PropertyListEncoder()
        
        do {
            let data =  try encoder.encode(itemArray)
            try data.write(to:dataFilePAth!)
        } catch{
            print("error encoding item array \(error)")
            
        }
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePAth!){
           let decoder = PropertyListDecoder()
            do{
            itemArray =  try decoder.decode([Item].self, from: data)
        } catch {
            print("Error")
        }
    }
    

}
}


