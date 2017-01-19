//
//  ToDo+CoreDataProperties.swift
//  ToDoList
//
//  Created by Alwin Lazar on 19/01/17.
//  Copyright © 2017 Xeoscript Technologies. All rights reserved.
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo");
    }

    @NSManaged public var title: String?
    @NSManaged public var created: NSDate?

}
