//
//  InterfaceController.swift
//  MiWeather WatchKit Extension
//
//  Created by Nadia Yudina on 2/13/15.
//  Copyright (c) 2015 Nadia Yudina. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    var week: [ForecastDay] = []
    
    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
        CacheDataStore.sharedCacheDataStore.allForecast { (forecastDays) -> () in
            self.table.setNumberOfRows(forecastDays.count, withRowType: "ForecastRow")
            for (index, day) in enumerate(forecastDays) {
                if let row = self.table.rowControllerAtIndex(index) as? ForecastRowController {
                    row.temperatureLabel.setText("\(Int(day.dayTemp)) C")
                    let dayImage = UIImage(named: day.iconName)
                    row.image.setImage(dayImage)
                    row.dateLabel.setText(day.dateToString(day.date))
                }
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
