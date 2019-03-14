//
//  AllListViewController.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation
import UIKit

class AllListViewController: UITableViewController {
    
    var listOfList = [CheckList]()
    
    var listOfItems1 : [ChecklistItem] = []
    var listOfItems2 : [ChecklistItem] = []
    var listOfItems3 : [ChecklistItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfItems1.append(ChecklistItem(text : "aze", checked : true))
        listOfItems1.append(ChecklistItem(text : "azer"))
        listOfItems1.append(ChecklistItem(text : "azert"))
        listOfItems2.append(ChecklistItem(text : "poi", checked : true))
        listOfItems2.append(ChecklistItem(text : "poiu"))
        listOfItems2.append(ChecklistItem(text : "poiuy"))
        listOfItems3.append(ChecklistItem(text : "qwe", checked : true))
        listOfItems3.append(ChecklistItem(text : "qwer"))
        listOfItems3.append(ChecklistItem(text : "qwert"))
        
        let checklist1 = CheckList(listName: "Liste 1", itemList : listOfItems1)
        let checkList2 = CheckList(listName: "Liste 2", itemList : listOfItems2)
        let checkList3 = CheckList(listName: "Liste 3", itemList : listOfItems3)
        
        listOfList.append(checklist1)
        listOfList.append(checkList2)
        listOfList.append(checkList3)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "viewCheckList") {
            let destVC = segue.destination as! ChecklistViewController
            
            let indexPath = tableView.indexPath(for :sender as! UITableViewCell)!
            destVC.checkList = listOfList[indexPath.row]
            destVC.title = listOfList[indexPath.row].name
        }
    }
    
    //MARK: - table view Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfList.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.listOfList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Checklist", for: indexPath)
        let item = listOfList[indexPath.row]
        configureText(for: cell, withItem: item)
        return cell
    }
    
    //MARK: - table view Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = listOfList[indexPath.row]
        
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }
    
    func configureText(for cell: UITableViewCell, withItem item: CheckList) {
        cell.textLabel?.text = item.name
    }
    
}
