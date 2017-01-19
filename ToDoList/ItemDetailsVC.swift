//
//  ItemDetailsVC.swift
//  ToDoList
//
//  Created by Alwin Lazar on 19/01/17.
//  Copyright © 2017 Xeoscript Technologies. All rights reserved.
//

import UIKit


class ItemDetailsVC: UIViewController {
    
    var taskDetails: ToDo?

    @IBOutlet weak var detailsLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // to clear the <DreamLIst to < only
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
            // this is execute when tap on an existing cell
            if taskDetails != nil {
                
                loadItemData()
            }
        }
        
    }
    
    func loadItemData() {
        
        if let task = taskDetails {
            
            detailsLbl.text = task.title
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        detailsLbl.sizeToFit()
    }
    
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if taskDetails != nil {
            
            context.delete(taskDetails!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }

}













