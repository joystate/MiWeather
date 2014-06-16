//
//  ViewController.swift
//  Weather
//
//  Created by Nadia Yudina on 6/14/14.
//  Copyright (c) 2014 Nadia Yudina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var week: Day[] = []
    
    @IBOutlet var tableView : UITableView
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let apiClient = WeatherAPIClient()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        var nipName = UINib(nibName: "WeatherCell", bundle:nil)
        self.tableView.registerNib(nipName, forCellReuseIdentifier: "Cell")
        
        apiClient.fetchForecast({ dict in
            
            var forecasts: Array<AnyObject> = dict["list"] as Array
            
            for forecast: AnyObject in forecasts {
                
                var day: Day = apiClient.forecastToDay(forecast)
                self.week.append(day)
            }

            println(self.week)
            self.tableView.reloadData()

        })

    }

    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        return self.week.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as WeatherCell
        var day = self.week[indexPath.row]
        
        cell.textLabel.text = day.description
        
        return cell
    }

    
    

}

