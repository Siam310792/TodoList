//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    var delegate : AddItemViewControllerDelegate?
    var itemToEdit : ChecklistItem?
    
    @IBOutlet weak var itemText: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    override func viewDidLoad() {
        if (itemToEdit != nil) {
            itemText.text = itemToEdit?.text
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
    }
    

    
    @IBAction func cancel(_ sender: Any) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done(_ sender: Any) {
        if (itemToEdit != nil) {
            itemToEdit?.text = itemText.text!
            delegate?.addItemViewController(self, didFinishEditingItem: itemToEdit!)
        } else {
            delegate?.addItemViewController(self, didFinishAddingItem: ChecklistItem(text: itemText.text!))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.itemText.becomeFirstResponder()
    }
    
    
}


//MARK: - UITextFieldDelegate
extension AddItemViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldString = textField.text!
        
        let newString = oldString.replacingCharacters(in: Range(range, in:                                              oldString)!,
            with: string)
        if(!newString.isEmpty){
            self.doneButton.isEnabled = true
        } else {
            self.doneButton.isEnabled = false
        }
        return true
    }
    
}

protocol AddItemViewControllerDelegate : class {
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: ChecklistItem)
}


