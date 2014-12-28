//
//  TaskModel.swift
//  TaskIt
//
//  Created by Yosemite on 12/27/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import Foundation
import CoreData

// Create an Object-C bridge, which in case we might use in future
@objc(TaskModel)


class TaskModel: NSManagedObject {

    @NSManaged var isCompleted: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
