//
//  AddViewController.swift
//  Sneaker
//
//  Created by Hengjun Wu on 4/18/20.
//  Copyright © 2020 Hengjun Wu. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
        
    @IBOutlet var nameField: UITextField!
    @IBOutlet var colorField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!

    var itemStore: ItemStore!
    var name: String = ""
    var valueInDollars: Int = 0
    var color: String = ""
    var dateCreated: Date

    required init?(coder aDecoder: NSCoder) {
        self.dateCreated = Date()
        
        super.init(coder: aDecoder)
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateLabel.text = dateFormatter.string(from: Date())
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Clear first responder
        view.endEditing(true)
        // "save" changes to item
        name = nameField.text ?? ""
        color = colorField.text!
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            valueInDollars = value.intValue
        } else {
            valueInDollars = 0
        }
    }
    
    // dismissing keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(dateCreated)
        return true
    }
    @IBAction func backgroudTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // validation function
    func validateFields() -> String? {
        //check if all fields are filled
        if (nameField.text == "" ||
            colorField.text == "" ||
            valueField.text == "" )
        {
            return "Please fill in all fields."
        }

        if NumberFormatter().number(from: valueField.text!) == nil {
            return "Value must be integer only."
        }
        
        return nil
    }
    
    // save item button
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let error = validateFields()
        
        if error != nil {
            dateLabel.text = dateFormatter.string(from: Date()) + "\n" + error!
        } else {
            name = nameField.text ?? ""
            color = colorField.text!
            if let valueText = valueField.text,
                let value = numberFormatter.number(from: valueText) {
                valueInDollars = value.intValue
            } else {
                valueInDollars = 0
            }
            dateCreated = Date()
            print(name,color,valueInDollars,dateCreated)
            //Create a new item and add it to the store
            itemStore.createItem(name,color,valueInDollars)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
