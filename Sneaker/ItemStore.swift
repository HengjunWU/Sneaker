//
//  ItemStore.swift
//  Sneaker
//
//  Created by 吴亨俊 on 4/17/20.
//  Copyright © 2020 吴亨俊. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    } ()
    
    init() {
        do {
            let data = try Data(contentsOf: itemArchiveURL)
            if let archivedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Item] {
                allItems = archivedData
            }
        } catch {
            allItems = []
        }
    }

    @discardableResult func createItem(_ name: String,_ serialNumber: String,_ valueInDollars: Int) -> Item {
        let newItem = Item(name: name, serialNumber: serialNumber, valueInDollars: valueInDollars)

        allItems.append(newItem)

        return newItem

    }
    
    func removeItem(_ item:Item){
        if let index = allItems.index(of:item){
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        // get reference to the object being moved so that we can reinsert it
        let movedItem = allItems[fromIndex]
        // rmove the item from array
        allItems.remove(at: fromIndex)
        // insert it in the array at the new position
        allItems.insert(movedItem, at: toIndex)
    }
    
    func saveChanges() -> Bool {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: allItems, requiringSecureCoding: false)
            try data.write(to:itemArchiveURL)
            print(itemArchiveURL)
            return true
        } catch {
            return false
        }
    }
    
}
