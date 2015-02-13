//
//  CacheDataStore.swift
//  MiWeather
//
//  Created by Nadia Yudina on 2/13/15.
//  Copyright (c) 2015 Nadia Yudina. All rights reserved.
//

import CoreData

class CacheDataStore {
    
    let context: NSManagedObjectContext
    let psc: NSPersistentStoreCoordinator
    let model: NSManagedObjectModel
    let store: NSPersistentStore?
    var folderName: String?
    
    class var sharedCacheDataStore: CacheDataStore {
        struct Static {
            static var instance: CacheDataStore?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = CacheDataStore()
        }
        return Static.instance!
    }
    
    // MARK: Core Data stack
    
    init() {
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("Cache", withExtension:"momd")
        model = NSManagedObjectModel(contentsOfURL: modelURL!)!
        psc = NSPersistentStoreCoordinator(managedObjectModel:model)
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = psc
        let documentsURL = applicationDocumentDirectory()
        let storeURL = documentsURL.URLByAppendingPathComponent("Cache")
        let options = [NSMigratePersistentStoresAutomaticallyOption: true]
        var error: NSError? = nil
        store = psc.addPersistentStoreWithType(NSSQLiteStoreType,
            configuration: nil, URL: storeURL, options: options, error:&error)
        if store == nil {
            println("Error adding persistent store: \(error)")
            abort()
        }
    }
    
    func applicationDocumentDirectory() -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        return urls[0]
    }
    
    func saveContext() {
        var error: NSError? = nil
        if context.hasChanges && !context.save(&error) {
            println("Could not save: \(error), \(error?.userInfo)")
        }
    }
}

