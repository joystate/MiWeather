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
    let urlStringForLocation: String = "/forecast/daily?lat=41&lon=74&cnt=10&mode=json"
    
    func fetchForecast(completion: (result: NSDictionary) -> ()) {
        
        var urlString: String = constants.baseURL + urlStringForLocation
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
}





