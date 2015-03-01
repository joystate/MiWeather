//
//  Locator.swift
//  MiWeather
//
//  Created by Nadia Yudina on 2/19/15.
//  Copyright (c) 2015 Nadia Yudina. All rights reserved.
//

import Foundation
import CoreLocation

class Locator: NSObject, CLLocationManagerDelegate {
    
    var seenError : Bool = false
    var locationStatus : NSString = "Not Started"
    var manager: CLLocationManager!
    
    override init() {
        super.init()
        seenError = false
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    //MARK: CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        self.manager.stopUpdatingLocation()
        if ((error) != nil) {
            if (seenError == false) {
                seenError = true
                print(error)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        manager.stopUpdatingLocation()
        var locationArray = locations as NSArray
        var locationObj = locationArray.lastObject as! CLLocation
        var coord = locationObj.coordinate
        CLGeocoder().reverseGeocodeLocation(locationObj, completionHandler: { (placemarks, error) -> Void in
            if ((error != nil)) {
               self.locationManager(self.manager, didFailWithError: error)
            }
            if (placemarks.count != 0) {
                let lastPlacemark: CLPlacemark? = placemarks.first as? CLPlacemark
                let latitude = lastPlacemark?.location.coordinate.latitude
                let longitude = lastPlacemark?.location.coordinate.longitude
                let locationInfo: [String: CLLocationDegrees] = ["lat": latitude!, "lon": longitude!]
                NSNotificationCenter.defaultCenter().postNotificationName("locationUpdatedNotification", object: nil, userInfo: locationInfo)
            } else {
                self.locationManager(self.manager, didFailWithError: error)
            }
        })
    }

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        switch status {
        case CLAuthorizationStatus.Restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.Denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.NotDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
        if (shouldIAllow == true) {
            // Start location services
            self.manager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
    }
}
