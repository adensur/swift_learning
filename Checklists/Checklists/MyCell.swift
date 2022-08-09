//
//  MyCell.swift
//  Checklists
//
//  Created by Maksim Gaiduk on 09/08/2022.
//

import UIKit

class MyCell: UITableViewCell {
    weak var delegate: MyCellDelegate!
    var rowIdx: Int = -1

    @IBOutlet weak var doneSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func doneSwitchValueChanged(_ sender: Any) {
        delegate.myCell(doneSwitchValueChangedTo: doneSwitch.isOn, rowIdx: self.rowIdx)
    }
    //@IBAction func doneSwitchValueChanged(_ sender: Any) {
    //delegate.myCell(doneSwitchValueChangedTo: true, rowIdx: self.rowIdx)
    //}
}

protocol MyCellDelegate : AnyObject {
    func myCell(doneSwitchValueChangedTo newValue: Bool, rowIdx: Int)
}
