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
    
    class func createLocation(#latitude: Double, longitude: Double, locality: String, managedObjectContext: NSManagedObjectContext) -> (Location?) {
        let locationEntity = NSEntityDescription.entityForName("Location", inManagedObjectContext: managedObjectContext)
        var location = Location(entity: locationEntity!, insertIntoManagedObjectContext: managedObjectContext)
        let fetchRequest = NSFetchRequest(entityName: "Location")
        fetchRequest.predicate = NSPredicate(format: "latitude == %@ AND longitude == %@", latitude, longitude)
        var error: NSError?
        let result = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as! [Location]?
        if let locations = result {
            if locations.count == 0 {
                var location = Location(entity: locationEntity!, insertIntoManagedObjectContext: managedObjectContext)
                location.latitude = latitude
                location.longitude = longitude
                location.locality = locality
                return location
            } else {
                return locations.first
            }
        } else {
            println("Could not fetch articles: \(error)")
            return nil
        }
    }
}
