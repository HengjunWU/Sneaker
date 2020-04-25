//
//  DetailViewController.swift
//  Sneaker
//
//  Created by Hengjun Wu on 4/18/20.
//  Copyright © 2020 Hengjun Wu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var colorField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var itemStore: ItemStore!

    var rowIndex: Int!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
    override  func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)

        nameField.text = item.name
        colorField.text = item.color
        
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder
        view.endEditing(true)
        // "save" changes to item
        item.name = nameField.text ?? ""
        item.color = colorField.text!
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    // dismissing keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func backgroudTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // trash can button for deleting
    @IBAction func trashAction(_ sender: UIBarButtonItem) {
        // ask user to confirm
        let title = "Delete \(self.item.name)?"
        let message = "Are you sure you want to delete this item?"

        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        ac.addAction(cancelAction)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            // remove the item from the store
            self.itemStore.removeItem(self.item)
            //also remove that row from the table view, with animation
            self.navigationController?.popViewController(animated: true)
        })

        ac.addAction(deleteAction)
        // put up the controller as a modal view
        present(ac, animated: true, completion: nil)
    }
}
