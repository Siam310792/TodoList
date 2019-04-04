//
//  CheckList.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation

class CheckList : Codable {
    var itemList : [ChecklistItem]
    var name : String
    
    var uncheckedItemsCount : Int {
        var nbItemCheck = 0
        for item in itemList {
            if (!item.checked) {
                nbItemCheck += 1
            }
        }
        return nbItemCheck
    }

    var icon : IconAsset
    
    init(listName : String, itemList : [ChecklistItem]) {
        self.itemList = itemList
        self.name = listName
        self.icon = IconAsset.NoIcon
    }
    
    init(listName : String) {
        self.name = listName
        self.itemList = []
        self.icon = IconAsset.NoIcon
    }
    
    
}
