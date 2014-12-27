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
        let task1:Dictionary<String,String> = ["task":"Study French", "subtask":"Verbs", "date":"01/01/2014"]
        let task2:Dictionary<String,String> = ["task":"Eat dinner", "subtask":"Vegi", "date":"11/21/2014"]
        let task3:Dictionary<String,String> = ["task":"Gym", "subtask":"Bench press", "date":"01/14/2014"]
        println(task1["task"])
        println(task1["subtask"])
        println(task1["date"])
        
        taskArrayDict = [task1, task2, task3]
        
        // Struct usage:
        let taskA = TaskModel(task: "Study French", subtask: "Verbs", date: "01/01/2014")
        let taskB = TaskModel(task: "Eat dinner", subtask: "Vegi", date: "11/21/2014")
        let taskC = TaskModel(task: "Gym", subtask: "Bench press", date: "01/14/2014")
        
        taskArrayStruct = [taskA, taskB, taskC]

        // Reloads rows and sections in TableView
        self.tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        return taskArrayDict.count
    }

    // indexPath: encapsulate both rows and sections
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("\(indexPath.row)")
        
        let taskDict:Dictionary = taskArrayDict[indexPath.row]
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
        cell.dateLabel.text = taskStruct.date
        
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
        
    }
}

