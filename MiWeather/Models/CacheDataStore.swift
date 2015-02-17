//
//  CacheDataStore.swift
//  MiWeather
//
//  Created by Nadia Yudina on 2/13/15.
//  Copyright (c) 2015 Nadia Yudina. All rights reserved.
//

import CoreData

public class CacheDataStore: NSObject {
    
    let weatherAPIClient = WeatherAPIClient()
    
    public class var sharedCacheDataStore: CacheDataStore {
        struct Static {
            static var instance: CacheDataStore?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            Static.instance = CacheDataStore()
        }
        return Static.instance!
    }
    
    // MARK: - Populate Core Data
    
    func fetchForecast(completion: (forecastDays: Array<ForecastDay>) -> ()) {
        var daysInForecast: [ForecastDay] = []
        weatherAPIClient.fetchForecast { (result) -> () in
            if let dict = result as? [String: AnyObject] {
                for weatherDict in dict["list"] as Array<[String: AnyObject]> {
                    let day = ForecastDay.createForecastDay(forecastDict: weatherDict, managedObjectContext: self.managedObjectContext!)
                    daysInForecast.append(day!)
                }
            }
            completion(forecastDays: daysInForecast)
        }
    }
    
    // MARK: - Core Data stack
    
    public lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "self.edu.com.Some" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .AllDomainsMask)
        return urls[urls.count-1] as NSURL
        }()
    
    public lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Cache", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    public lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let containerPath = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.projects.miweather.Documents")
        let sqliteURL = containerPath?.URLByAppendingPathComponent("db.sqlite")
//        let sqlitePath = NSString(format: "%@/%@", containerPath!, "Cache")
//        let url = NSURL(fileURLWithPath: sqlitePath)

        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: sqliteURL, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    public lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    public func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }
}

