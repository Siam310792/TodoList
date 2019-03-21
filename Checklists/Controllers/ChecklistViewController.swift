//
//  ViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var checkList : CheckList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addItem") {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! ItemDetailViewController
            destVC.title = "Add Item"
            destVC.delegate = self as ItemDetailViewControllerDelegate
        } else if (segue.identifier == "editItem"){
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! ItemDetailViewController
            destVC.delegate = self as ItemDetailViewControllerDelegate
            destVC.title = "Edit Item"
            var indexOfSelectedCell = tableView.indexPath(for: (sender as! ChecklistItemCell))
            destVC.itemToEdit = checkList.itemList[indexOfSelectedCell!.row]
        }
    }
    
    //MARK: - table view Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkList.itemList.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.checkList.itemList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.none)
        //saveCheckListItems(checklist: checkList.itemList)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! ChecklistItemCell
        let item = checkList.itemList[indexPath.row]
        configureText(for: cell, withItem: item)
        configureCheckmark(for: cell, withItem: item)
        
        return cell
    }
    
    //MARK: - table view Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = checkList.itemList[indexPath.row]
        item.toggleCheck()
        
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }
    
    //MARK: -
    func configureCheckmark(for cell: ChecklistItemCell, withItem item: ChecklistItem) {
        cell.checkmark.isHidden = !item.checked
    }
    
    func configureText(for cell: ChecklistItemCell, withItem item: ChecklistItem) {
        cell.itemName.text = item.text
    }
    
    @IBAction func addDummyTodo(_ sender: Any) {
        checkList.itemList.append(ChecklistItem(text: "Nouvelle tâche"))
        tableView?.insertRows(at:[NSIndexPath(row: checkList.itemList.count-1, section: 0) as IndexPath], with: .automatic)
    }
}

extension ChecklistViewController : ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        controller.dismiss(animated:true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        controller.dismiss(animated:true)
        checkList.itemList.append(item)
        tableView?.insertRows(at:[NSIndexPath(row: checkList.itemList.count-1, section: 0) as IndexPath], with: .automatic)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        controller.dismiss(animated:true)
        let indexOfEditedItem = checkList.itemList.index(where:{ $0 === item })
        tableView?.reloadRows(at:[NSIndexPath(row:indexOfEditedItem!, section: 0) as IndexPath], with: .automatic)
    }
}
