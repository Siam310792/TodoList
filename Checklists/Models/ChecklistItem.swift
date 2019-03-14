//
//  ChecklistItem.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit


class ChecklistItem : Codable {
    
    var text : String
    var checked : Bool
    
    init(text : String, checked : Bool) {
        self.text = text
        self.checked = checked
    }
    
    init(text : String) {
        self.text = text
        self.checked = false
    }
    
    func toggleCheck() {
        if (self.checked) {
            self.checked = false
        } else {
            self.checked = true
        }
    }
}

