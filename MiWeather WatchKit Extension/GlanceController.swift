//
//  GlanceController.swift
//  MiWeather
//
//  Created by Nadia Yudina on 2/18/15.
//  Copyright (c) 2015 Nadia Yudina. All rights reserved.
//

import WatchKit
import Foundation

class GlanceController: WKInterfaceController {
    
    @IBOutlet weak var dateLabel: WKInterfaceLabel!
    @IBOutlet weak var temperatureLabel: WKInterfaceLabel!
    @IBOutlet weak var image: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        CacheDataStore.sharedCacheDataStore.allForecast { (forecastDays) -> () in
            let today: ForecastDay = forecastDays.first!
            self.dateLabel.setText(today.dateToString(today.dateWithoutTime(today.date)))
            self.temperatureLabel.setText("\(Int(today.dayTemp)) C")
            self.image.setImage(UIImage(named: today.iconName))
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
