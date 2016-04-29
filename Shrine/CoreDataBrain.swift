//
//  CoreDataBrain.swift
//  Shrine
//
//  Created by Jaden Nation on 4/28/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import CoreData

class CoreDataBrain: NSObject {
  // MARK: -- variables
  var shrineDescription: NSEntityDescription! ; var promiseDescription: NSEntityDescription! ; var visitDescription: NSEntityDescription!
  
  
  // MARK: -- custom functions
  func saveObject(obj: NSManagedObject) {
    // save to db
  }
  
  func saveObjectToDB(obj: NSManagedObject, closure: ((NSManagedObject)->())? = nil) {
    do {
      try obj.managedObjectContext?.save()
      SAFE(closure) { $0(obj) }
      print("Object successfully saved to DB")
    } catch {
      print ("Unable to save.  Error occurred")
    }
  }
  
  
  func resultsOfRequest(desc: NSEntityDescription) -> [AnyObject] {
    let out = [AnyObject]()
    let request = NSFetchRequest()
    request.entity = desc
    do {
      let result = try managedObjectContext.executeFetchRequest(request)
      if result.count > 0 { return result }
    } catch {
      let fetchError = error as NSError
      print(fetchError)
    }
    return out
  }
  
  
  // MARK: -- required functions
  override init()  {
    super.init()
    shrineDescription = NSEntityDescription.entityForName(Core_ObjTitle.shrine.rawValue, inManagedObjectContext: managedObjectContext)!
    promiseDescription = NSEntityDescription.entityForName(Core_ObjTitle.promise.rawValue, inManagedObjectContext: managedObjectContext)!
    visitDescription = NSEntityDescription.entityForName(Core_ObjTitle.visit.rawValue, inManagedObjectContext: managedObjectContext)!
  }
  
 
  // MARK: -- persistentStore and context functions
  lazy var managedObjectModel: NSManagedObjectModel = {
    let modelURL = NSBundle.mainBundle().URLForResource("ShrineDB_Model", withExtension: "momd")!
    return NSManagedObjectModel(contentsOfURL: modelURL)!
  }()
  
  lazy var managedObjectContext: NSManagedObjectContext = {
    let persistentStoreCoordinator = self.persistentStoreCoordinator
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    
    return managedObjectContext
  }()
  
  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let URLs = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    let applicationDocumentsDirectory = URLs[(URLs.count - 1)]
    let URLPersistentStore = applicationDocumentsDirectory.URLByAppendingPathComponent("ShrineDB_Model.sqlite")
    
    do {
      // Add Persistent Store to Persistent Store Coordinator
      try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: URLPersistentStore, options: nil)
      
    } catch {
      // Populate Error
      var userInfo = [String: AnyObject]()
      userInfo[NSLocalizedDescriptionKey] = "There was an error creating or loading the application's saved data."
      userInfo[NSLocalizedFailureReasonErrorKey] = "There was an error creating or loading the application's saved data."
      
      userInfo[NSUnderlyingErrorKey] = error as NSError
      let wrappedError = NSError(domain: "com.DesignerJeans.Shrine", code: 1001, userInfo: userInfo)
      
      NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
      
      abort()
    }
    
    return persistentStoreCoordinator
  }()
  
  
} // end of custom class