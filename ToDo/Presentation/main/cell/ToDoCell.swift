//
//  ToDoCell.swift
//  ToDo
//
//  Created by Ali on 2022/11/17.
//

import UIKit

class ToDoCell: UITableViewCell {
    // MARK: - Variables
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    var seeMore: (()->())? = nil
    var checked: ((Bool)->())? = nil
    let selectableWidth = 64.0
    @IBOutlet weak var selectorWidthConst: NSLayoutConstraint!
    var data: ToDoData? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(data: ToDoData, seeMore: @escaping ()->(), checked: @escaping (Bool)->()){
        self.data = data
        self.seeMore = seeMore
        self.checked = checked
        setCheckMark()
        title.text = data.title
        let checkBoxWidth = data.isSelectable ? selectableWidth : 0
        self.selectorWidthConst.constant = checkBoxWidth
        UIView.animate(withDuration: 0.2) {
            self.title.layoutIfNeeded()
            self.checkBox.layoutIfNeeded()
        }
    }
    
    func setCheckMark(){
        if data?.isCompleted == true{
            checkBox.setImage(.init(systemName: "checkmark.circle.fill"), for: .normal)
        }else{
            checkBox.setImage(.init(systemName: "checkmark.circle"), for: .normal)
        }
    }
    
    @IBAction func checkMarkClicked(_ sender: Any) {
        guard data != nil else{
            return
        }
        data!.isCompleted = !data!.isCompleted
        setCheckMark()
        if let action = checked{
            action(data!.isCompleted)
        }
    }
    
    @IBAction func seeMoreClicked(_ sender: UIButton) {
        if let action = seeMore{
            action()
        }
    }
}
