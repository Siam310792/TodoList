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
    
    var documentDirectory : URL {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.allDomainsMask).first!
    }
    
    var dataFileUrl : URL {
        return documentDirectory.appendingPathComponent("Checklists").appendingPathExtension("json")
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(dataFileUrl)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addItem") {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! ItemDetailViewController
            destVC.title = "Add Item"
            destVC.delegate = self
        } else if (segue.identifier == "editItem"){
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! ItemDetailViewController
            destVC.delegate = self
            destVC.title = "Edit Item"
            var indexOfSelectedCell = tableView.indexPath(for: (sender as! ChecklistItemCell))
            destVC.itemToEdit = checkList.itemList[indexOfSelectedCell!.row]
        }
    }
    
    override func awakeFromNib() {
        //loadChecklistItems()
    }
    
    //MARK: - table view Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkList.itemList.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.checkList.itemList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.none)
        saveCheckListItems(checklist: checkList.itemList)
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
        
        saveCheckListItems(checklist: checkList.itemList)
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
        saveCheckListItems(checklist: checkList.itemList)
    }
    
    //MARK: - Save data
    func saveCheckListItems(checklist : [ChecklistItem]) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data = try! encoder.encode(checklist)
        try? data.write(to: dataFileUrl)
    }
    
    //Déplacer loadChecklistItems dans AllList car c'est lui qui va gérer la récupération des listes.
   /* func loadChecklistItems() {
        if FileManager.default.fileExists(atPath: dataFileUrl.path) {
            let data = try! Data(contentsOf: dataFileUrl)
            let decoder = JSONDecoder()
            checkList.itemList = try! decoder.decode([ChecklistItem].self, from: data)
        } else {
            checkList.itemList.append(ChecklistItem(text: "Faire la vaisselle"))
            checkList.itemList.append(ChecklistItem(text: "Passer l'aspirateur"))
            checkList.itemList.append(ChecklistItem(text: "Faire les courses"))
            checkList.itemList.append(ChecklistItem(text: "Nettoyer la litière du chat", checked: true))
            checkList.itemList.append(ChecklistItem(text: "Sortir les poubelles", checked: true))
        }
    }*/
}

extension ChecklistViewController : ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        controller.dismiss(animated:true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        controller.dismiss(animated:true)
        checkList.itemList.append(item)
        tableView?.insertRows(at:[NSIndexPath(row: checkList.itemList.count-1, section: 0) as IndexPath], with: .automatic)
        saveCheckListItems(checklist: checkList.itemList)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        controller.dismiss(animated:true)
        let indexOfEditedItem = checkList.itemList.index(where:{ $0 === item })
        tableView?.reloadRows(at:[NSIndexPath(row:indexOfEditedItem!, section: 0) as IndexPath], with: .automatic)
        saveCheckListItems(checklist: checkList.itemList)
    }
}
