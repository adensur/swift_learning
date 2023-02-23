//
//  ViewController.swift
//  Checklists
//
//  Created by Maksim Gaiduk on 21/07/2022.
//

import UIKit

protocol CheckListViewControllerDelegate: AnyObject {
    func checkListViewReturnToAllList()
}

class CheckListViewController: UITableViewController, AddItemTableViewControllerDelegate, MyCellDelegate {
    func myCell(doneSwitchValueChangedTo newValue: Bool, rowIdx: Int) {
        self.checklist.items[rowIdx].isChecked = newValue
        self.tableView.reloadRows(at: [IndexPath(row: rowIdx, section: 0)], with: .automatic)
    }
    
    weak var delegate: CheckListViewControllerDelegate!
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController) {
        
    }
    
    @IBAction func returnToAllChecklists(_ sender: Any) {
        self.delegate.checkListViewReturnToAllList()
        navigationController?.popViewController(animated: true)
    }
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: Item) {
        self.checklist.items.append(item)
        self.tableView.insertRows(at: [IndexPath(row: self.checklist.items.count - 1, section: 0)], with: .automatic)
    }
    
    func addItemViewController(
      _ controller: AddItemTableViewController,
      didFinishEditing item: Item, row: Int) {
          self.tableView.reloadRows(at: [IndexPath(row:row, section:0)], with: .automatic)
      }
    
    
    weak var checklist: Checklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.checklist.name
        // Do any additional setup after loading the view.
    }

    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
        return self.checklist.items.count
    }

    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ChecklistItem",
        for: indexPath) as! MyCell

      // Add the following code
        cell.delegate = self
        cell.rowIdx = indexPath.row
      let label = cell.viewWithTag(13337) as! UILabel
        let doneSwitch = cell.viewWithTag(11) as! UISwitch
      let item = self.checklist.items[indexPath.row]
        label.text = item.descr
        let checkmark = cell.viewWithTag(1) as! UILabel
        if item.isChecked {
            checkmark.text = "✓"
            doneSwitch.isOn = true
        } else {
            checkmark.text = ""
            doneSwitch.isOn = false
        }
      return cell
    }
    
    // react to tap on a row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = self.checklist.items[indexPath.row]
            item.isChecked.toggle()
            let checkmark = cell.viewWithTag(1) as! UILabel
            if item.isChecked {
                checkmark.text = "✓"
            } else {
                checkmark.text = ""
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // react to row swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        self.checklist.items.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }

    
    // MARK: - Navigation
    override func prepare(
      for segue: UIStoryboardSegue,
      sender: Any?
    ) {
      // 1
      if segue.identifier == "AddItem" {
        // 2
        let controller = segue.destination as! AddItemTableViewController
        // 3
        controller.delegate = self
      } else if segue.identifier == "EditItem" {
          let childController = segue.destination as! AddItemTableViewController
          childController.delegate = self
          let cell = sender as! UITableViewCell
          let rowIndex = tableView.indexPath(for: cell)!
          childController.itemToEdit = self.checklist.items[rowIndex.row]
          childController.itemToEditIdx = rowIndex.row
      }
    }

}

