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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Manually reference the protocal: Give the datasource/delegate the access to the ViewController
        // self.tableView.dataSource = self
        // self.tableView.delegate = self
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
        if section == 0 {
            return 5
        } else {
            return 3
        }
        
        //return 5
    }

    // indexPath: encapsulate both rows and sections
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("\(indexPath.row)")
        
        // Returns a reusable cell object (located by its identifier)
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        cell.taskLabel.text = "Study French"
        cell.descriptionLabel.text = "Verbs in past and presence"
        cell.dateLabel.text = "01/01/2014"
        
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

