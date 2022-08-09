//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by Maksim Gaiduk on 02/08/2022.
//

import UIKit

protocol AddItemTableViewControllerDelegate: AnyObject {
  func addItemViewControllerDidCancel(
    _ controller: AddItemTableViewController)
  func addItemViewController(
    _ controller: AddItemTableViewController,
    didFinishAdding item: Item
  )
  func addItemViewController(
    _ controller: AddItemTableViewController,
    didFinishEditing item: Item, row: Int)
}

class AddItemTableViewController: UITableViewController, UITextFieldDelegate {
    weak var delegate: AddItemTableViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationItem.largeTitleDisplayMode = .never
        textField.becomeFirstResponder()
        if let itemToEdit = self.itemToEdit {
            self.title = "Edit Item"
            self.textField.text = itemToEdit.descr
            self.shouldRemindSwitch.isOn = itemToEdit.shouldRemind
            self.datePicker.date = itemToEdit.dueDate
        }
    }

    // MARK: - Table view data source
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var itemToEdit: Item?
    var itemToEditIdx: Int?
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
      navigationController?.popViewController(animated: true)
    }

    @IBAction func done() {
        if let itemToEdit = itemToEdit {
            print("Editing to ", textField.text!)
            itemToEdit.descr = textField.text!
            itemToEdit.dueDate = datePicker.date
            itemToEdit.shouldRemind = shouldRemindSwitch.isOn
            delegate?.addItemViewController(self, didFinishEditing: itemToEdit, row: self.itemToEditIdx!)
        } else {
            let item = Item(textField.text!)
            item.dueDate = datePicker.date
            item.shouldRemind = shouldRemindSwitch.isOn
            delegate?.addItemViewController(self, didFinishAdding: item)
        }
      navigationController?.popViewController(animated: true)
    }

    // MARK: - Text Field Delegates
    func textField(
      _ textField: UITextField,
      shouldChangeCharactersIn range: NSRange,
      replacementString string: String
    ) -> Bool {
      let oldText = textField.text!
      let stringRange = Range(range, in: oldText)!
      let newText = oldText.replacingCharacters(
        in: stringRange,
        with: string)
        doneButton.isEnabled = !newText.isEmpty
      return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
      doneButton.isEnabled = false
      return true
    }
    
}
