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
        //self.table.setNumberOfRows(3, withRowType: "ForecastRow")
        // Configure interface objects here.
        NSLog("%@ init", self)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        CacheDataStore.sharedCacheDataStore.allForecast { (forecastDays) -> () in
            self.table.setNumberOfRows(forecastDays.count, withRowType: "ForecastRow")
        }

        NSLog("%@ will activate", self)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }
    
}
