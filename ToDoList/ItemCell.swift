//
//  ItemCell.swift
//  ToDoList
//
//  Created by Alwin Lazar on 18/01/17.
//  Copyright © 2017 Xeoscript Technologies. All rights reserved.
//

import UIKit

protocol ToDoCellDelegate: class {
    func toDoCellButtonPressed(todo: ToDo?)
}

class ItemCell: UITableViewCell {

    @IBOutlet weak var taskTitle: UILabel!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    var toDo: ToDo?
    
    weak var delegate: ToDoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        doneBtn.addTarget(self, action: #selector(buttonPress), for: UIControlEvents.touchUpInside)
    }
    
    func configureCell(toDo: ToDo, delegate: ToDoCellDelegate) {
        
        self.delegate = delegate
        self.toDo = toDo
        taskTitle.text = toDo.title
        
        
        
    }
    
    func buttonPress() {
        
        
        self.delegate?.toDoCellButtonPressed(todo: self.toDo)
    }
    

}
