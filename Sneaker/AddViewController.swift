//
//  AddViewController.swift
//  Sneaker
//
//  Created by 吴亨俊 on 4/18/20.
//  Copyright © 2020 吴亨俊. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
        
    @IBAction func backgroudTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
//
//    var item: Item! {
//        didSet {
//            navigationItem.title = item.name
//        }
//    }
//
    var itemStore: ItemStore!
    var name: String = ""
    var valueInDollars: Int = 0
    var serialNumber: String = ""
    var dateCreated: Date
    required init?(coder aDecoder: NSCoder) {
        self.dateCreated = Date()
        super.init(coder: aDecoder)
    }
    
    func p() {
        print(itemStore.allItems)
    }
//
//    var rowIndex: Int!
//
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


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Clear first responder
        view.endEditing(true)
        // "save" changes to item
        name = nameField.text ?? ""
        serialNumber = serialNumberField.text!
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            valueInDollars = value.intValue
        } else {
            valueInDollars = 0
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        p()
        print(dateCreated)
        return true
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        name = nameField.text ?? ""
        serialNumber = serialNumberField.text!
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            valueInDollars = value.intValue
        } else {
            valueInDollars = 0
        }
        dateCreated = Date()
        print(name,serialNumber,valueInDollars,dateCreated)
        //Create a new item and add it to the store
        itemStore.createItem(name,serialNumber,valueInDollars)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
