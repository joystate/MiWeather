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
        let fetchRequest = NSFetchRequest(entityName: "ForecastDay")
        var unixDate: Double = JSON["dt"] as Double
        var date: NSDate = epochToDateWithoutTime(unixDate)
        fetchRequest.predicate = NSPredicate(format: "date == %@", date)
        var error: NSError?
        let cachedForecast = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as Array<ForecastDay>
        if cachedForecast.count == 0 {
            var day = ForecastDay(entity: dayEntity!, insertIntoManagedObjectContext: managedObjectContext)
            day.date = date
            let temperatureDict: Dictionary<String, Double> = JSON["temp"] as Dictionary
            day.dayTemp = temperatureDict["day"]! as Double
            day.nightTemp = temperatureDict["night"]! as Double
            day.humidity = JSON["humidity"]! as Double
            day.pressure = JSON["pressure"]! as Double
            let weatherArray: Array<AnyObject> = JSON["weather"] as Array
            day.weatherDescription = weatherArray[0]["description"] as String
            day.iconName = weatherArray[0]["icon"] as String
            return day
        } else {
            return cachedForecast[0]
        }
}
    
    class func epochToDateWithoutTime (unixTime: Double) -> NSDate {
        var interval: NSTimeInterval = unixTime
        var date = NSDate(timeIntervalSince1970:interval)
        let calendar = NSCalendar.currentCalendar()
        let components: NSDateComponents = calendar.components(.CalendarUnitYear
            | .CalendarUnitMonth
            | .CalendarUnitDay, fromDate: date)
        return calendar.dateFromComponents(components)!
    }
}