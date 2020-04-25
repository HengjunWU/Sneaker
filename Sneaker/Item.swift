//
//  Item.swift
//  Sneaker
//
//  Created by Hengjun Wu on 4/17/20.
//  Copyright © 2020 Hengjun Wu. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    var name: String
    var valueInDollars: Int
    var color: String
    let dateCreated: Date
    
    init(name: String, color: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.color = color!
        self.dateCreated = Date()
        
        super.init()
    }
    
    // archiving
    func encode(with aCoder:NSCoder){
        aCoder.encode(name,forKey: "name")
        aCoder.encode(dateCreated,forKey: "dateCreated")
        aCoder.encode(color,forKey: "color")
        aCoder.encode(valueInDollars,forKey: "valueInDollars")
    }
    required init(coder aDeCoder: NSCoder) {
        name = aDeCoder.decodeObject(forKey: "name") as! String
        dateCreated = aDeCoder.decodeObject(forKey: "dateCreated") as! Date
        color = aDeCoder.decodeObject(forKey: "color") as! String
        valueInDollars = aDeCoder.decodeInteger(forKey: "valueInDollars")
        super.init()
    }
}
