//
//  DataModel.swift
//  Checklists
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation
import UIKit

class DataModel {
    static let shared = DataModel()
    
    var documentDirectory : URL {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.allDomainsMask).first!
    }
    
    var dataFileUrl : URL {
        return documentDirectory.appendingPathComponent("Checklists").appendingPathExtension("json")
    }
    
    var listOfList = [CheckList]()
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveCheckList),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil)
    }
    
    //MARK: - Save data
    @objc func saveCheckList() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data = try! encoder.encode(listOfList)
        try? data.write(to: dataFileUrl)
    }
    
    func loadChecklist() {
        if FileManager.default.fileExists(atPath: dataFileUrl.path) {
            let data = try! Data(contentsOf: dataFileUrl)
            let decoder = JSONDecoder()
            listOfList = try! decoder.decode([CheckList].self, from: data)
        } else {
            listOfList.append(CheckList(listName: "Ménage" , itemList: [ChecklistItem(text: "Faire la vaisselle", checked: true), ChecklistItem(text: "Passer l'aspirateur")]))
            listOfList.append(CheckList(listName: "Pour Anniversaire" , itemList: [ChecklistItem(text: "Acheter des bougies", checked: true), ChecklistItem(text: "Aller chercher le gâteau")]))
        }
    }
}
