//
//  ToDo+CoreDataClass.swift
//  ToDoList
//
//  Created by Alwin Lazar on 19/01/17.
//  Copyright © 2017 Xeoscript Technologies. All rights reserved.
//

import Foundation
import CoreData


public class ToDo: NSManagedObject {

    public override func awakeFromInsert() {
        
        self.created = NSDate()
    }
}
