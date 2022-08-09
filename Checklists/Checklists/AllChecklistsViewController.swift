//
//  AllChecklistsViewController.swift
//  Checklists
//
//  Created by Maksim Gaiduk on 08/08/2022.
//

import UIKit

class AllChecklistsViewController: UITableViewController, AddChecklistDelegate, CheckListViewControllerDelegate {
    var dataModel = DataModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let idx = self.dataModel.getLastEnteredChecklistIdx() {
            print("Got user defaults idx ", idx)
            segueToChecklist(idx: idx)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func checkListViewReturnToAllList() {
        self.dataModel.setLastEnteredChecklistIdx(nil)
    }

    func addChecklist(addedChecklist checklist: Checklist) {
        self.dataModel.checklists.append(checklist)
        let iPath = IndexPath(row: self.dataModel.checklists.count - 1, section: 0)
        tableView.insertRows(at: [iPath], with: .automatic)
        self.dataModel.setLastEnteredChecklistIdx(nil)
    }
    
    func addChecklistCancelEditing() {
        self.dataModel.setLastEnteredChecklistIdx(nil)
    }
    
    func addChecklist(finishEditing row: Int) {
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
        self.dataModel.setLastEnteredChecklistIdx(nil)
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataModel.checklists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let tmp = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") {
            cell = tmp
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        }

        // Configure the cell...
        let checklist = self.dataModel.checklists[indexPath.row]
        cell.textLabel?.text = checklist.name
        cell.detailTextLabel!.text = "Tasks remaining: \(checklist.countChecked())"
        cell.accessoryType = .detailButton
        cell.imageView!.image = UIImage(named: checklist.icon)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowChecklist", sender: tableView.cellForRow(at:indexPath))
    }
    
    func segueToChecklistEdit(idx: Int) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "AddChecklistViewController") as! AddChecklistViewController
        controller.delegate = self
        controller.checklistToEdit = self.dataModel.checklists[idx]
        controller.checklistToEditIdx = idx
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func segueToChecklist(idx: Int) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "CheckListViewController") as! CheckListViewController
        controller.checklist = self.dataModel.checklists[idx]
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        segueToChecklistEdit(idx: indexPath.row)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddChecklist" {
            let controller = segue.destination as! AddChecklistViewController
            controller.delegate = self
        } else if segue.identifier == "ShowChecklist" {
            let cell = sender as! UITableViewCell
            let controller = segue.destination as! CheckListViewController
            let ip = tableView.indexPath(for: cell)!
            self.dataModel.setLastEnteredChecklistIdx(ip.row)
            controller.delegate = self
            controller.checklist = self.dataModel.checklists[ip.row]
        }
    }
}
