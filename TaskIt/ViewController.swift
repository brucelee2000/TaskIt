//
//  ViewController.swift
//  TaskIt
//
//  Created by Yosemite on 12/26/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    
    var taskArrayDict:[Dictionary<String,String>] = []
    var taskArrayStruct:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        let taskA = TaskModel(task: "Study French", subtask: "Verbs", date: Date.from(year: 2014, month: 1, day: 1))
        let taskB = TaskModel(task: "Eat dinner", subtask: "Vegi", date: Date.from(year: 2014, month: 11, day: 21))
        let taskC = TaskModel(task: "Gym", subtask: "Bench press", date: Date.from(year: 2014, month: 1, day: 14))
        
        taskArrayStruct = [taskA, taskB, taskC]

        // Reloads rows and sections in TableView
        self.tableView.reloadData()

    }
    
    // Function called when transition back to current ViewController from somewhere else
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Refresh data on this tableView
        self.tableView.reloadData()
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
            let thisTask = taskArrayStruct[indexPath!.row]
            detailVC.detailTaskModel = thisTask
            
            // 3. Transfer main VC to target VC, so that target VC can access data in main VC
            detailVC.mainVC = self
        } else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskVC.mainVC = self
        }
    
    }

    // +------      Protocal: UITableViewDataSource              ------+
    // +           Represents the data model object.                   +
    // +---------------------------------------------------------------+
    
    // One tableview can have many sections, each of which can have multiple rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
        if section == 0 {
            return 5
        } else {
            return 3
        }
        */
        
        return taskArrayStruct.count
    }

    // indexPath: encapsulate both rows and sections
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("\(indexPath.row)")
        
        /*
        let taskDict:Dictionary = taskArrayDict[indexPath.row]
        */
        let taskStruct:TaskModel = taskArrayStruct[indexPath.row]
        
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        
        /* Segue: Initiation/Start
        *  Initiate segue with specified identifier from view controller storyboard
        */
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }
}

