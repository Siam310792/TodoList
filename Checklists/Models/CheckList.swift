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
    
    init(listName : String, itemList : [ChecklistItem]) {
        self.itemList = itemList
        self.name = listName
    }
    
    init(listName : String) {
        self.name = listName
        self.itemList = []
    }
}
