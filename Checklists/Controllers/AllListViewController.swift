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
    
    var dataModel = DataModel.shared
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "viewCheckList") {
            let destVC = segue.destination as! ChecklistViewController
            let indexPath = tableView.indexPath(for :sender as! UITableViewCell)!
            destVC.checkList = dataModel.listOfList[indexPath.row]
            destVC.title = dataModel.listOfList[indexPath.row].name
        } else if (segue.identifier == "addCategory") {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! CategoryDetailViewController
            destVC.title = "Add Item"
            destVC.delegate = self
        } else if (segue.identifier == "editCategory") {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! CategoryDetailViewController
            destVC.title = "Edit Item"
            destVC.delegate = self
            var indexOfSelectedCategory = tableView.indexPath(for: sender as! UITableViewCell)
            destVC.itemToEdit = dataModel.listOfList[indexOfSelectedCategory!.row]
        }
    }
    
    override func awakeFromNib() {
        dataModel.loadChecklist()
    }
    
    //MARK: - table view Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.listOfList.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.dataModel.listOfList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Checklist", for: indexPath)
        let item = dataModel.listOfList[indexPath.row]
        configureText(for: cell, withItem: item)
        return cell
    }
    
    //MARK: - table view Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //let item = listOfList[indexPath.row]
        
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }
    
    func configureText(for cell: UITableViewCell, withItem item: CheckList) {
        cell.textLabel?.text = item.name
    }
    
}

extension AllListViewController : CategoryDetailViewControllerDelegate {
    func categoryDetailViewControllerDidCancel(_ controller: CategoryDetailViewController) {
        controller.dismiss(animated:true)
    }
    
    func categoryDetailViewController(_ controller: CategoryDetailViewController, didFinishAddingCategory item: CheckList) {
        controller.dismiss(animated:true)
        dataModel.listOfList.append(item)
        tableView?.insertRows(at:[NSIndexPath(row: dataModel.listOfList.count-1, section: 0) as IndexPath], with: .automatic)
    }
    
    func categoryDetailViewController(_ controller: CategoryDetailViewController, didFinishEditingCategory item: CheckList) {
        controller.dismiss(animated:true)
        let indexOfEditedItem = dataModel.listOfList.index(where:{ $0 === item })
        tableView?.reloadRows(at:[NSIndexPath(row:indexOfEditedItem!, section: 0) as IndexPath], with: .automatic)
    }
}

