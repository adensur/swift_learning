//
//  AddChecklistViewController.swift
//  Checklists
//
//  Created by Maksim Gaiduk on 08/08/2022.
//

import UIKit

protocol AddChecklistDelegate: AnyObject {
    func addChecklist(addedChecklist checklist: Checklist)
    func addChecklist(finishEditing row: Int)
    func addChecklistCancelEditing()
}

class AddChecklistViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    weak var delegate: AddChecklistDelegate?
    weak var checklistToEdit: Checklist?
    var checklistToEditIdx: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let checklistToEdit = self.checklistToEdit {
            self.title = "Edit checklist"
            self.textField.text = checklistToEdit.name
        }
        self.textField.becomeFirstResponder()
    }

    @IBAction func cancelTapped(_ sender: Any) {
        self.delegate?.addChecklistCancelEditing()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func returnTapped(_ sender: Any) {
        self.delegate?.addChecklist(addedChecklist: Checklist(textField.text!))
        navigationController?.popViewController(animated: true)
    }
    @IBAction func doneButton(_ sender: Any) {
        if let checklistToEdit = checklistToEdit {
            checklistToEdit.name = textField.text!
            self.delegate?.addChecklist(finishEditing: self.checklistToEditIdx!)
        } else {
            self.delegate?.addChecklist(addedChecklist: Checklist(textField.text!))
        }
        navigationController?.popViewController(animated: true)
    }
    
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
