//
//  CacheDataStore.swift
//  MiWeather
//
//  Created by Nadia Yudina on 2/13/15.
//  Copyright (c) 2015 Nadia Yudina. All rights reserved.
//

import CoreData
import CoreLocation

public class CacheDataStore {
    
    let updateInterval: NSTimeInterval = 43200
    var managedObjectContext: NSManagedObjectContext?
    let persistentStoreCoordinator: NSPersistentStoreCoordinator
    var model: NSManagedObjectModel?
    let store: NSPersistentStore?
    var storeURL: NSURL?
    let locator = Locator()
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
    
    func fetchForecast(#latitude: Double, longitude: Double, completion: (forecastDays: Array<ForecastDay>) -> ()) {
        CacheDataStore.sharedCacheDataStore.allForecast { (forecastDays) -> () in
            let today = forecastDays.first
            if (forecastDays.count < 7 || today?.date.timeIntervalSinceNow > self.updateInterval) {
                var daysInForecast: [ForecastDay] = []
                
                self.weatherAPIClient.fetchForecast(latitude: latitude, longitude: longitude, completion: { (result) -> () in
                    if let dict = result as? [String: AnyObject] {
                        for weatherDict in dict["list"] as! Array<[String: AnyObject]> {
                            let day = ForecastDay.createForecastDay(forecastDict: weatherDict, managedObjectContext: self.managedObjectContext!)
                            daysInForecast.append(day!)
                        }
                    }
                    self.saveContext()
                    completion(forecastDays: daysInForecast)
                })
            } else {
                completion(forecastDays: forecastDays);
            }
        }
    }
        
    func allForecast (completion:(forecastDays: Array<ForecastDay>) -> ()) {
        let fetchRequest = NSFetchRequest(entityName: "ForecastDay")
        var error: NSError?
        let forecastArray = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: &error) as! Array<ForecastDay>
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let sortedForecast = (forecastArray as NSArray).sortedArrayUsingDescriptors([sortDescriptor]) as! Array<ForecastDay>
        completion(forecastDays: sortedForecast)
    }
    
    // MARK: - Core Data stack
    
    init() {
        let fileManager = NSFileManager.defaultManager()
        let appGroupIdentifier = "group.projects.miweather.Documents"
        let containerURL = fileManager.containerURLForSecurityApplicationGroupIdentifier(appGroupIdentifier)
        storeURL = containerURL!.URLByAppendingPathComponent("Cache.sqlite")
        
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("Cache", withExtension: "momd")
        model = NSManagedObjectModel(contentsOfURL: modelURL!)!
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model!)
        managedObjectContext = NSManagedObjectContext()
        managedObjectContext!.persistentStoreCoordinator = persistentStoreCoordinator
        let options = [NSMigratePersistentStoresAutomaticallyOption: true]
        var error: NSError? = nil
        store = persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType,
            configuration: nil, URL: storeURL, options: options, error: &error)
        if store == nil {
            println("Error adding persistent store: \(error)")
            abort()
        }
    }

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

