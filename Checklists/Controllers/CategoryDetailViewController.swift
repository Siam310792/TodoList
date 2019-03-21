//
//  CategoryDetailViewController.swift
//  Checklists
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UITableViewController {

    var delegate : CategoryDetailViewControllerDelegate?
    var itemToEdit : CheckList?
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        if (itemToEdit != nil) {
            categoryTextField.text = itemToEdit?.name
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
    }
   
    @IBAction func Cancel(_ sender: Any) {
        delegate?.categoryDetailViewControllerDidCancel(self)
    }
    
    @IBAction func Done(_ sender: Any) {
        if (itemToEdit != nil) {
            itemToEdit?.name = categoryTextField.text!
            delegate?.categoryDetailViewController(self, didFinishEditingCategory: itemToEdit!)
        } else {
            delegate?.categoryDetailViewController(self, didFinishAddingCategory: CheckList(listName: categoryTextField.text!))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.categoryTextField.becomeFirstResponder()
    }
    
    
}

//MARK: - UITextFieldDelegate
extension CategoryDetailViewController: UITextFieldDelegate{
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

protocol CategoryDetailViewControllerDelegate : class {
    func categoryDetailViewControllerDidCancel(_ controller: CategoryDetailViewController)
    
    func categoryDetailViewController(_ controller: CategoryDetailViewController, didFinishAddingCategory item:CheckList)
    
    func categoryDetailViewController(_ controller: CategoryDetailViewController, didFinishEditingCategory item:CheckList)
}
