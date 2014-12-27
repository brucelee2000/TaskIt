//
//  Date.swift
//  TaskIt
//
//  Created by Yosemite on 12/26/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import Foundation

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
