//
//  DataModel.swift
//  Checklists
//
//  Created by Maksim Gaiduk on 08/08/2022.
//

import Foundation

class Item: Codable {
    var isChecked = false
    var descr: String
    init(_ descr: String) {
        self.itemId = UserDefaults.standard.integer(forKey: "ItemId")
        UserDefaults.standard.set(self.itemId + 1, forKey: "ItemId")
        self.descr = "\(self.itemId): \(descr)"
    }
    var itemId = -1
    var shouldRemind = false
    var dueDate = Date()
}

class Checklist: Codable {
    var name: String
    var items: [Item] = []
    var icon: String = "No Icon"
    init(_ name: String) {
        self.name = name
    }
    
    func countChecked() -> Int {
        return self.items.reduce(0, {cnt, item in
            return cnt + (item.isChecked ? 0 : 1)
        })
    }
}

class DataModel: Codable {
    var checklists: [Checklist] = []
    
    func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)
      return paths[0]
    }

    func dataFilePath() -> URL {
      return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveData() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.checklists)
            try data.write(to: dataFilePath())
        } catch {
            print("Got error: \(error.localizedDescription)")
        }
    }
    
    func loadData() {
        if let data = try? Data(contentsOf: dataFilePath()) {
            do {
                let decoder = PropertyListDecoder()
                self.checklists = try decoder.decode([Checklist].self, from: data)
            } catch {
                print("Got error: \(error.localizedDescription)")
            }
        }
    }
    
    func getLastEnteredChecklistIdx() -> Int? {
        let idx = UserDefaults.standard.integer(forKey: "LastEnteredChecklistIdx")
        if idx >= 0 && idx < self.checklists.count {
            return idx
        } else {
            return nil
        }
    }
    
    func setLastEnteredChecklistIdx(_ idx: Int?) {
        var finalIdx = -1
        if let idx = idx {
            finalIdx = idx
        }
        print("Set user defaults idx: ", finalIdx)
        UserDefaults.standard.set(finalIdx, forKey: "LastEnteredChecklistIdx")
    }
    
    func setUpDefaults() {
        let defs = ["LastEnteredChecklistIdx": -1, "DidHandleFirstTime": false] as [String: Any]
        UserDefaults.standard.register(defaults: defs)
    }
    
    func handleFirstTime() {
        if !UserDefaults.standard.bool(forKey: "DidHandleFirstTime") {
            self.checklists.append(Checklist("To do items"))
            UserDefaults.standard.set(true, forKey: "DidHandleFirstTime")
        }
    }
    
    init() {
        setUpDefaults()
        loadData()
        handleFirstTime()
    }
}
