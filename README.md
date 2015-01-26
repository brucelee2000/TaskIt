# TaskIt
NSDate Creation and Format
--------------------------
**Creation**
* Construct a NSDate component with current date by calling *NSDateComponents*
* Obtain current calender by calling *NSCalendar*
* Change NSDate component to a NSDate with current calendar's method *dateFromComponents*

**Format**
* Create a NSDate formatter by calling *NSDateFormatter*
* Configure this formatter to target format with its method *dateFormat*
* Format NSDate to target string by calling *stringFromDate*

        class Date {
            // # as parameter name identifier when the function is called
            class func from (#year:Int, month:Int, day:Int) -> NSDate {
                var components = NSDateComponents()
                components.year = year
                components.month = month
                components.day = day
                
                var gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)
                var date = gregorianCalendar?.dateFromComponents(components)
                
                return date!
            }
            
            class func toString(#date:NSDate) -> String {
                let dateStringFormatter = NSDateFormatter()
                dateStringFormatter.dateFormat = "MM-dd-yyyy"
                let dateString = dateStringFormatter.stringFromDate(date)
                
                return dateString
            }
        }

Dismiss current ViewController
------------------------------
Current VC is dismissed and the view will go back to previous one.

**When current view is shown by "present modally' in segue**

    @IBAction func cancelButtonPressed(sender: UIButton) {
        // Dismiss ViewController when there's no navigation controller
        // - Segue is "Present Modally"
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
**When current view is shown by "show" in segue**

    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        // Dismiss ViewController automatically if navigation controller still exists
        // - Segue is "Show"
        // If not, Pops the top view controller from the navigation stack and updates the display.
        self.navigationController?.popViewControllerAnimated(true)
    }
    
Refresh data in ViewController
------------------------------

    // Reloads rows and sections in TableView
    self.tableView.reloadData()
    
Sorting data by closure or embedded function
--------------------------------------------

        // Use embedded function to sort
        func sortByDate(taskOne:TaskModel, taskTwo:TaskModel) -> Bool {
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        taskArrayStruct = taskArrayStruct.sorted(sortByDate)
        
        // Use closure to sort
        taskArrayStruct = taskArrayStruct.sorted({ (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
            taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        })

        // Reloads rows and sections in TableView
        self.tableView.reloadData()
        
Headers customization in TableView
----------------------------------
  
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
    
"Swipe" for the cell in tableView
---------------------------------

    // Asks the data source to commit the insertion or deletion of a specified row in the receiver.
    // aka. Add "Swipe" function and its action for the cell in tableView.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
            var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, isCompleted: true)
            baseArray[1].append(newTask)
        } else {
            var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, isCompleted: false)
            baseArray[0].append(newTask)
        }
        
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        
        // Use closure to sort
        baseArray[0] = baseArray[0].sorted({ (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
            taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        })
        
        tableView.reloadData()
    }
