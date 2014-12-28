//
//  ViewController.swift
//  TaskIt
//
//  Created by Yosemite on 12/26/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    /*
    var taskArrayDict:[Dictionary<String,String>] = []
    var taskArrayStruct:[TaskModel] = []
    var completedArray = [TaskModel(task: "Code", subtask: "Task Project", date: Date.from(year: 2014, month: 11, day: 21), isCompleted: true)]
    
    var baseArray:[[TaskModel]] = []
    */
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var myFetchResultsController:NSFetchedResultsController = NSFetchedResultsController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*

        // Build the protocal references (allow protocals to access ViewController):
        // - Method 1 in storyboard: Drag tableview onto the view controller and select datasource and delegate
        // - Method 2 in codes:  see the codes below
        // self.tableView.dataSource = self
        // self.tableView.delegate = self
        
        // Dictionary usage:
        let task1:Dictionary<String,String> = ["task":"Study French", "subtask":"Verbs", "date":Date.toString(date:Date.from(year: 2014, month: 1, day: 1))]
        let task2:Dictionary<String,String> = ["task":"Eat dinner", "subtask":"Vegi", "date":Date.toString(date:Date.from(year: 2014, month: 11, day: 21))]
        let task3:Dictionary<String,String> = ["task":"Gym", "subtask":"Bench press", "date":Date.toString(date:Date.from(year: 2014, month: 1, day: 14))]
        println(task1["task"])
        println(task1["subtask"])
        println(task1["date"])
        
        taskArrayDict = [task1, task2, task3]
        
        // Struct usage:
        let taskA = TaskModel(task: "Study French", subtask: "Verbs", date: Date.from(year: 2014, month: 1, day: 1), isCompleted: false)
        let taskB = TaskModel(task: "Eat dinner", subtask: "Vegi", date: Date.from(year: 2014, month: 11, day: 21), isCompleted: false)
        let taskC = TaskModel(task: "Gym", subtask: "Bench press", date: Date.from(year: 2014, month: 1, day: 14), isCompleted: false)
        
        taskArrayStruct = [taskA, taskB, taskC]
        
        baseArray = [taskArrayStruct, completedArray]
        
        // Use embedded function to sort
        func sortByDate(taskOne:TaskModel, taskTwo:TaskModel) -> Bool {
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        baseArray[0] = baseArray[0].sorted(sortByDate)
        
        // Use closure to sort
        baseArray[0] = baseArray[0].sorted({ (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
            taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        })

        // Reloads rows and sections in TableView
        self.tableView.reloadData()

        */
        
        // Setup data fetch method from CoreData
        myFetchResultsController = getFetchedResultsController()
        
        // Give the access of this VC to myFetchResultsController
        myFetchResultsController.delegate = self
        
        // Fetch the data
        myFetchResultsController.performFetch(nil)

    }
    
    // Function called when transition back to current ViewController from somewhere else
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Segue: Preparation
    *  Notify the view controller that a segue is about to perform
    *  - called right before desitination view controller appears on the screen
    *  - used to transfer data to destination view controller from current view controller
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            // 1. Make target VC available for main VC
            let detailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            
            // Locate selected row: use sender (since send is passed as self in performSegueWithIdentifier)
            //let taskVC:ViewController = sender! as ViewController
            //let indexPath = taskVC.tableView.indexPathForSelectedRow()
            
            // Locate selected row: use self
            let indexPath = self.tableView.indexPathForSelectedRow()
            
            // 2. Transfer data in main VC to target VC
            let thisTask = myFetchResultsController.objectAtIndexPath(indexPath!) as TaskModel
            detailVC.detailTaskModel = thisTask
            
        } else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
        }
    
    }

    // +------      Protocal: UITableViewDataSource              ------+
    // +           Represents the data model object.                   +
    // +---------------------------------------------------------------+
    
    // Return the number of sections in the table view
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return myFetchResultsController.sections!.count
    }
    
    // One tableview can have many sections, each of which can have multiple rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
        if section == 0 {
            return 5
        } else {
            return 3
        }
        */
        
        return myFetchResultsController.sections![section].numberOfObjects
    }

    // indexPath: encapsulate both rows and sections
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("\(indexPath.row)")
        
        /*
        let taskDict:Dictionary = taskArrayDict[indexPath.row]
        */
        let taskStruct:TaskModel = myFetchResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        // Returns a reusable cell object (located by its identifier)
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        /*
        cell.taskLabel.text = taskDict["task"]
        cell.descriptionLabel.text = taskDict["subtask"]
        cell.dateLabel.text = taskDict["date"]
        */
        
        cell.taskLabel.text = taskStruct.task
        cell.descriptionLabel.text = taskStruct.subtask
        cell.dateLabel.text = Date.toString(date: taskStruct.date)
        
        // If there are multiple prototype cells
        if indexPath.row == 0 {
            // return 1st prototype cell
        } else if indexPath.row == 1{
            // return 2nd prototype cell
        }
        
        return cell
    }
    
    // +------      Protocal: UITableViewDelegate                ------+
    // +       Represents the display and behaviour of the cells       +
    // +---------------------------------------------------------------+
    
    // Tells the delegate that the specified row is now selected.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        
        /* Segue: Initiation/Start
        *  Initiate segue with specified identifier from view controller storyboard
        */
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }
    
    // Asks the delegate for the height to use for the header of a particular section: set section header height
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    // Asks the data source for the title of the header of the specified section of the table view: set section header title
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To do"
        } else {
            return "Completed"
        }
    }
    
    // Asks the data source to commit the insertion or deletion of a specified row in the receiver.
    // aka. Add "Swipe" function and its action for the cell in tableView.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = myFetchResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        if indexPath.section == 0 {
            thisTask.isCompleted = true
        } else {
            thisTask.isCompleted = false
        }
        
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    // Notifies the receiver that the fetched results controller has completed processing of one or more changes due to an add, remove, move, or update.
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    // Helper
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "isCompleted", ascending: true)
        // The array here means multiple sortdescriptor is allowed, here we only do date
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        // "sectionNameKeyPath" determines the number of sections in tableView
        var fetchResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "isCompleted", cacheName: nil)
        
        return fetchResultsController
    }
}

