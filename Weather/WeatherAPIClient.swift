//
//  WeatherAPIClient.swift
//  Weather
//
//  Created by Nadia Yudina on 6/14/14.
//  Copyright (c) 2014 Nadia Yudina. All rights reserved.
//

import Foundation

class WeatherAPIClient: NSObject {
    
    let constants = Constants()
    let urlStringForLocation: String = "/forecast/daily?lat=40.7127&lon=-74.0059&cnt=7&units=metric&mode=json&APPID="
    
    func fetchForecast(completion: (result: NSDictionary) -> ()) {
        
        var urlString: String = constants.baseURL + urlStringForLocation + constants.weatherAPIKey
        var url: NSURL = NSURL.URLWithString(urlString)
        var request: NSURLRequest = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            var error: NSError
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            
            completion(result: jsonResult)
            
            
            })
        
        task.resume()
    }
    
    
    func forecastToDay (forecast: AnyObject) -> Day {
        
        var humidity: String = String(forecast["humidity"]! as Int)
        var pressure: String = String(forecast["pressure"]! as Double)
        var unixDate: Double = forecast["dt"] as Double
        var dateString: String = self.epochToDate(unixDate)
        
        var tempDict: Dictionary<String, Double> = forecast["temp"] as Dictionary
        var dayTemp: String = String(tempDict["day"]! as Double)
        var nightTemp: String = String(tempDict["night"]! as Double)
        
        var weatherArray: Array<AnyObject> = forecast["weather"] as Array
        var identif: String = String(weatherArray[0]["id"] as Int)
        var weatherDesc: String = weatherArray[0]["description"] as String
        var iconName: String = weatherArray[0]["icon"] as String
        
        var day = Day(date: dateString, dayTemp: dayTemp, nightTemp: nightTemp, pressure: pressure, humidity: humidity, identif: identif, weatherDescription: weatherDesc, iconName: iconName)
        
        return day
    }
    
    
    func epochToDate (unixTime: Double) -> String {
        
        var interval: NSTimeInterval = unixTime
        var date = NSDate(timeIntervalSince1970:interval)
        
        var dateFmt = NSDateFormatter()
        var format: String = "dd-MM"
        dateFmt.dateFormat = format
        var dateString: String = dateFmt.stringFromDate(date)
        
        return dateString
    }

    
}





