//
//  File.swift
//  Sneaker
//
//  Created by Hengjun Wu on 4/17/20.
//  Copyright © 2020 Hengjun Wu. All rights reserved.
//

import UIKit

class ItemViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered segue is the "showItem" segue
        switch segue.identifier {
            case "showItem"?:
                // Figure out which row was just tapped
                if let row = tableView.indexPathForSelectedRow?.row {
                    // Get the item associated with this row and pass it along
                    let item = itemStore.allItems[row]
                    let detailViewController
                        = segue.destination as! DetailViewController
                    detailViewController.item = item
                    detailViewController.rowIndex = row
                    detailViewController.itemStore = itemStore
                }
            case "addItem"?:
                // go to addView segue
                let addViewController = segue.destination as! AddViewController
                addViewController.itemStore = itemStore

        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = itemStore.allItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.nameLabel.text = item.name
        cell.colorLabel.text = item.color
        cell.valueLabel.text = "$\(item.valueInDollars)"
        return cell
    }
    
    // for deleting a row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    // if the table view is asking to commit a delete command (this will give
    // us a chance to intercept the delete if we want to)
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            // ask user to confirm
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                // remove the item from the store
                self.itemStore.removeItem(item)
                //also remove that row from the table view, with animation
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            ac.addAction(deleteAction)
            // put up the controller as a modal view
            present(ac, animated: true, completion: nil)

        }
        
    }

    override func tableView(_ tableView:UITableView,moveRowAt sourceIndexPath:IndexPath, to destinationIndexPath:IndexPath){
        //Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


}
