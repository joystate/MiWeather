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
                
                var day: Day = apiClient.forecastToDay(forecast)
                self.week.append(day)
            }

            println(self.week)

        })

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

