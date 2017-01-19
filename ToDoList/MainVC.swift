//
//  ViewController.swift
//  ToDoList
//
//  Created by Alwin Lazar on 18/01/17.
//  Copyright © 2017 Xeoscript Technologies. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, ToDoCellDelegate {
    
    var controller: NSFetchedResultsController<ToDo>!
    
    @IBOutlet weak var taskTextField: CustomTextField!
    @IBOutlet weak var tableView: UITableView!
    
    var toDo: ToDo!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        generateData()
        attemptFetch()
        
    }
    
    
    // to give view to cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        

        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        
        return cell
    }
    
    // custom function
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        
        let toDo = controller.object(at: indexPath as IndexPath)
        
        // call the method on the ItemCell
        cell.configureCell(toDo: toDo, delegate: self)
    
        
        
    }
    
    func toDoCellButtonPressed(selectedToDo: ToDo?) {
        
        if let t = selectedToDo {
            //tell context to delete todo and remove cell.
            context.delete(t)
            ad.saveContext()
            
            
        }
    
    }
    
    // when select a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // it ensure it have object and atleast one object in there
        if let objs = controller.fetchedObjects, objs.count > 0 {
            
            let task = objs[indexPath.row]
            
            performSegue(withIdentifier: "ItemDetailsVC", sender: task)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ItemDetailsVC" {
            
            if let destination = segue.destination as? ItemDetailsVC {
                
                if let task = sender as? ToDo {
                    
                    destination.taskDetails = task
                }
            }
        }
    }
    
    // count of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // we check here if any sections then take info of them and count
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            
            return sectionInfo.numberOfObjects
            
        }
        
        return 0
    }
    
    // column count
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections {
            
            return sections.count
            
        }
        
        return 0
    }
    
    // give height of a cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    // fetching function
    func attemptFetch() {
        
        // create a fetch request with fetching Entity
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        
        // sorting area
        let dateSort = NSSortDescriptor(key: "created", ascending: true)
        
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        // actual fetching
        do {
            
            try controller.performFetch()
            
        } catch {
            
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    // when tableView changes this function starts listen for changes and
    // it will handle that for you
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    // this function will listen for when we make change
    // insertion, deletion .. etc
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case.update:
            if let indexPath = indexPath {
                
                let cell = tableView.cellForRow(at: indexPath)
                //update the cell data
                
                configureCell(cell: cell as! ItemCell, indexPath: indexPath as NSIndexPath)
            }
            
            break
            
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            
            break
            
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            
            }
            
            break
            
            
        case.move:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath)
                //update the cell data
                
                configureCell(cell: cell as! ItemCell, indexPath: indexPath as NSIndexPath)
            }
            
            if let newIndexPath = newIndexPath {
                let cell = tableView.cellForRow(at: newIndexPath)
                //update the cell data
                
                configureCell(cell: cell as! ItemCell, indexPath: newIndexPath as NSIndexPath)
            }
            
            break
    }
}

    @IBAction func addBtnPressed(_ sender: UIButton) {
        
        if taskTextField.text != "" && taskTextField.text != nil {
        
        toDo = ToDo(context: context)
        
        if let task = taskTextField.text {
            
            toDo.title = task
        }
        
        ad.saveContext()
        
        taskTextField.text = ""
            
            
        }
        
    }
    
    func generateData() {
        
        let task = ToDo(context: context)
        task.title = "alwin"
        
        let task1 = ToDo(context: context)
        task1.title = "rambo"
        
        let task2 = ToDo(context: context)
        task2.title = "monisha"
        
        let task3 = ToDo(context: context)
        task3.title = "wounderlist"
        
        let task4 = ToDo(context: context)
        task4.title = "presentation"
        
        let task5 = ToDo(context: context)
        task5.title = "roundup"
        
        // to save data
        ad.saveContext()
    }
    
   

}

//extension MainVC: ToDoCellDelegate {
//    func toDoCellButtonPress(toDo: ToDo?) {
//        if let t = toDo {
//            //tell context to delete todo and remove cell.
//            
//            context.delete(t)
//            ad.saveContext()
//            
//            tableView.reloadData()
//        }
//    }
//}



























