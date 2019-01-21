//
//  CategoryViewController.swift
//  Todooey
//
//  Created by Kyle Patterson on 2019-01-19.
//  Copyright © 2019 sun wolf. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

       
    }
    
    // Mark: - TableView Data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "no categories added yet."
        
        return cell
    }
    
      // Mark: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! LoDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    // Mark: - Manipulation methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error found saving category. \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
       categories = realm.objects(Category.self)
        
   
        tableView.reloadData()
        
    }
    
    //Mark:- add new categories

   
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new category", message: "<#T##String?#>", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "action", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
        self.save(category: newCategory)
           
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "add new category "
        }
        
        present(alert, animated: true, completion: nil)
    }
    
   
    
  
    
    

    
}
