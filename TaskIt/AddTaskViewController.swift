//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Yosemite on 12/26/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        // Dismiss ViewController when there's no navigation controller
        // - Segue is "Present Modally"
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addTaskButtonPressed(sender: UIButton) {
        /*
        var task = TaskModel(task: taskTextField.text, subtask: subtaskTextField.text, date: dueDatePicker.date, isCompleted: false)
        mainVC.baseArray[0].append(task)
        */
        
        /*
        ** CoreData Process flow:
        ** 1. Access our managed object context(already created in the app delegate) by appDelegate instance
        ** 2. Access our entity(TaskModel)
        ** 3. Tie the entity to the managed object context
        ** 4. Set the entity(TaskModel) attributes
        ** 5. Save it to CoreData by calling saveContext()
        */
        
        // 0. Obtain an instance of appDelegate (AppDelegate.swift)
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        // 1. Use appDelegate to access ManagedObjectContext
        let managedObjectContext = appDelegate.managedObjectContext
        
        // 2. Access the entity information
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        
        // 3. Create an instance of our entity with our managedObjectContext tied in
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        // 4. Set the entity atttibutes
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        task.isCompleted = false
        
        // 5. Save the changes
        appDelegate.saveContext()
        
        
        // Process for reading data from CoreData
        
        // 1. Prepare the request by NSFetchRequest
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        
        // 2. Fetch the request
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        // 3. Review the results
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
