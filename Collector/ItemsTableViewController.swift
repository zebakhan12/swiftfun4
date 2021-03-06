//
//  ItemsTableViewController.swift
//  Collector
//
//  Created by Zeba Khan on 5/3/18.
//  Copyright © 2018 Zeba Khan. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    //creating a property of an array of items that will be stored in core data
    var items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //calling the most recent version of core data titles and images
        getItems()
    }
    
    //method or function to pull info from core data
    func getItems() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            //unwrapping code
            if let coreDataStuff = try? context.fetch(Item.fetchRequest()) as? [Item] {
                if let coreDataItems = coreDataStuff {
                    items = coreDataItems
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        //code to "pull" the title field from Core Data array
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        
        //need to write code to "pull" image from Core Data array and display on the main page
        //need to convert the current image format which is now data into the format of an UI image
        
        if let imageData = item.image{
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    // once you change it to true people will be able to swipe to left and delete.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // this is the name of function, tells you what users can do with the a particular row, this is saying someone can delete row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //access to core data context
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            //current item in indexPath, need to call index path
                let item = items[indexPath.row]
            //telling the code what item needs to be deleted
                context.delete(item)
            //just bc you delete something from core data does not change the array, we need alert to completely update the core data table view
                getItems()
        }
                        
        }
    }
}
