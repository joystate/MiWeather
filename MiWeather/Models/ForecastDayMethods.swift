//
//  File.swift
//  MiWeather
//
//  Created by Nadia Yudina on 2/17/15.
//  Copyright (c) 2015 Nadia Yudina. All rights reserved.
//

import Foundation
import CoreData

extension ForecastDay {
    
    class func createForecastDay(forecastDict JSON: NSDictionary, managedObjectContext: NSManagedObjectContext) -> (ForecastDay?) {
        let dayEntity = NSEntityDescription.entityForName("ForecastDay", inManagedObjectContext: managedObjectContext)
        var day = ForecastDay(entity: dayEntity!, insertIntoManagedObjectContext: managedObjectContext)
        var unixDate: Double = JSON["dt"] as! Double
        day.date = epochToDate(unixDate)
        let temperatureDict: Dictionary<String, Double> = JSON["temp"]as! Dictionary
        day.dayTemp = temperatureDict["day"]! as Double
        day.nightTemp = temperatureDict["night"]! as Double
        day.humidity = JSON["humidity"]! as! Double
        day.pressure = JSON["pressure"]! as! Double
        let weatherArray: Array<AnyObject> = JSON["weather"] as! Array
        day.weatherDescription = weatherArray[0]["description"] as! String
        day.code = weatherArray[0]["id"] as! Int
        day.iconName = weatherArray[0]["icon"] as! String
        return day
    }
    
    class func epochToDate (unixTime: Double) -> NSDate {
        var interval: NSTimeInterval = unixTime
        var date = NSDate(timeIntervalSince1970:interval)
        return date
    }
    
    func dateWithoutTime (date: NSDate) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components: NSDateComponents = calendar.components(.CalendarUnitYear
            | .CalendarUnitMonth
            | .CalendarUnitDay, fromDate: date)
        return calendar.dateFromComponents(components)!
    }
    
    func dateToString(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.stringFromDate(self.date)
    }
}