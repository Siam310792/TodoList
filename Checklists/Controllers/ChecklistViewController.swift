//
//  ViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var checkListItemList : [ChecklistItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkListItemList.append(ChecklistItem(text: "Faire la vaisselle"))
        checkListItemList.append(ChecklistItem(text: "Passer l'aspirateur"))
        checkListItemList.append(ChecklistItem(text: "Faire les courses"))
        checkListItemList.append(ChecklistItem(text: "Nettoyer la litière du chat", checked: true))
        checkListItemList.append(ChecklistItem(text: "Sortir les poubelles", checked: true))

        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: - table view Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkListItemList.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.checkListItemList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = checkListItemList[indexPath.row]
        configureText(for: cell, withItem: item)
        configureCheckmark(for: cell, withItem: item)
        
        return cell
    }
    
    //MARK: - table view Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = checkListItemList[indexPath.row]
        item.toggleCheck()
        
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        
    }
    
    //MARK: -
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem) {
        cell.accessoryType = (item.checked) ? .checkmark : .none
    }
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem) {
        cell.textLabel?.text = item.text
    }
    
    @IBAction func addDummyTodo(_ sender: Any) {
        checkListItemList.append(ChecklistItem(text: "Nouvelle tâche"))
        tableView?.insertRows(at:[NSIndexPath(row: checkListItemList.count-1, section: 0) as IndexPath], with: .automatic)
    }
}
