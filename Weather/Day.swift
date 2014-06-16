//
//  Day.swift
//  Weather
//
//  Created by Nadia Yudina on 6/15/14.
//  Copyright (c) 2014 Nadia Yudina. All rights reserved.
//

import UIKit

class Day: NSObject {
    
    var date: String?
    var dayTemp: String?
    var nightTemp: String?
    var pressure: String?
    var humidity: String?
    var identif: String?
    var weatherDescription: String?
    var iconName: String?
    
    
    init(date: String, dayTemp: String, nightTemp: String, pressure: String, humidity: String, identif: String, weatherDescription: String, iconName: String) {
        self.date = date
        self.dayTemp = dayTemp
        self.nightTemp = nightTemp
        self.pressure = pressure
        self.humidity = humidity
        self.identif = identif
        self.weatherDescription = weatherDescription
        self.iconName = iconName
    }
    
    
    func description() -> String {
        return "Day humidity: \(self.humidity), day temp: \(self.dayTemp), day icon name: \(self.iconName)"
    }
   
}
