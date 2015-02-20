//
//  File.swift
//  MiWeather
//
//  Created by Nadia Yudina on 2/19/15.
//  Copyright (c) 2015 Nadia Yudina. All rights reserved.
//

import Foundation
import CoreData

extension Location {
    
    class func createLocationSameAsPrevious(#latitude: Double, longitude: Double, locality: String, managedObjectContext: NSManagedObjectContext) -> (Bool) {
        let locationEntity = NSEntityDescription.entityForName("Location", inManagedObjectContext: managedObjectContext)
        var location = Location(entity: locationEntity!, insertIntoManagedObjectContext: managedObjectContext)
        let fetchRequest = NSFetchRequest(entityName: "Location")
        fetchRequest.predicate = NSPredicate(format: "latitude == %@ AND longitude == %@", latitude, longitude)
        var error: NSError?
        let result = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as! [Location]?
        if let locations = result {
            if locations.count == 0 {
                var location = Location(entity: locationEntity!, insertIntoManagedObjectContext: managedObjectContext)
                //round first decimal place is worth up to 11.1 km
                location.latitude = Double(round(latitude*10)/10)
                location.longitude = Double(round(longitude*10)/10)
                location.locality = locality
                return false
            } else {
                return true
            }
        } else {
            println("Could not fetch articles: \(error)")
            return false
        }
    }
}
