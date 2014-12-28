//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Yosemite on 12/26/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    // Used to pass main ViewController so that this controller can access all the properties in main ViewController
    var mainVC:ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        // Dismiss ViewController when there's no navigation controller
        // - Segue is "Present Modally"
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addTaskButtonPressed(sender: UIButton) {
        var task = TaskModel(task: taskTextField.text, subtask: subtaskTextField.text, date: dueDatePicker.date, isCompleted: false)
        mainVC.baseArray[0].append(task)
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
