//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Yosemite on 12/26/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    // Variable to save data transferred from other ViewController
    var detailTaskModel:TaskModel!
    
    // Variable to transfer back to main ViewController
    var mainVC:ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        // Dismiss ViewController when navigation controller still exists
        // - Segue is "Show"
        // Pops the top view controller from the navigation stack and updates the display.
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        var task = TaskModel(task: taskTextField.text, subtask: subtaskTextField.text, date: dueDatePicker.date, isCompleted: false)
        mainVC.baseArray[mainVC.tableView.indexPathForSelectedRow()!.section][mainVC.tableView.indexPathForSelectedRow()!.row] = task
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //println(self.detailTaskModel.task)
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subtask
        self.dueDatePicker.date = detailTaskModel.date
        
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
