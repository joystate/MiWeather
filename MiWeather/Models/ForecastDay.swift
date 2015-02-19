//
//  ForecastDay.swift
//  MiWeather
//
//  Created by Nadia Yudina on 2/19/15.
//  Copyright (c) 2015 Nadia Yudina. All rights reserved.
//

import Foundation
import CoreData

class ForecastDay: NSManagedObject {

    @NSManaged var code: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var dayTemp: NSNumber
    @NSManaged var humidity: NSNumber
    @NSManaged var iconName: String
    @NSManaged var nightTemp: NSNumber
    @NSManaged var pressure: NSNumber
    @NSManaged var weatherDescription: String
    @NSManaged var location: Location

}
