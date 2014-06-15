//
//  ViewController.swift
//  Weather
//
//  Created by Nadia Yudina on 6/14/14.
//  Copyright (c) 2014 Nadia Yudina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var week: Day[] = []
                            
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let apiClient = WeatherAPIClient()
        
        apiClient.fetchForecast({ dict in
            
            var forecasts: Array<AnyObject> = dict["list"] as Array
            
            for forecast: AnyObject in forecasts {
                
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
                
                self.week.append(day)

            }
            
            
            println(self.week)

            })

    }
    
    func epochToDate (unixTime: Double) -> String {
        
        var interval: NSTimeInterval = unixTime
        var date = NSDate(timeIntervalSince1970:interval)
        
        var dateFmt = NSDateFormatter()
        var format: String = "dd-MM-yyyy"
        dateFmt.dateFormat = format
        var dateString: String = dateFmt.stringFromDate(date)
        
        return dateString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

