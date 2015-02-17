//
//  ViewController.swift
//  Weather
//
//  Created by Nadia Yudina on 6/14/14.
//  Copyright (c) 2014 Nadia Yudina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var week: [ForecastDay] = []
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var tableView : UITableView = UITableView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.frame = CGRectMake(30, self.view.frame.height/2, self.view.frame.width-50, 1)
        self.spinner.startAnimating()
        let apiClient = WeatherAPIClient()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.allowsSelection = false
        var nipName = UINib(nibName: "WeatherCell", bundle:nil)
        self.tableView.registerNib(nipName, forCellReuseIdentifier: "Cell")
        
        CacheDataStore.sharedCacheDataStore.fetchForecast { (forecastDays) -> () in
            self.week = forecastDays
            self.spinner.stopAnimating()
            self.tableView.reloadData()
            UIView.animateWithDuration(0.7, delay: 1.0, options: .CurveEaseOut, animations: {
                self.tableView.frame = CGRectMake(30, 20,
                    self.view.frame.width - 50, self.view.frame.height - 50)
                }, completion: { finished in
                    println("opened!")
            })
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.week.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as WeatherCell
        var day = self.week[indexPath.row]
        cell.mainLabel.text = day.dateToString(day.dateWithoutTime(day.date))
        var dayImage = UIImage(named: day.iconName)
        var nightImage = UIImage(named: day.iconName)
        cell.dayView.image = dayImage
        cell.dayView.alpha = 0.5
        cell.nigthView.image = nightImage
        cell.nigthView.alpha = 0.5
        cell.dayLabel!.text = "\(Int(day.dayTemp)) C"
        cell.nightLabel!.text = "\(Int(day.nightTemp)) C"
        return cell
    }
    
}

