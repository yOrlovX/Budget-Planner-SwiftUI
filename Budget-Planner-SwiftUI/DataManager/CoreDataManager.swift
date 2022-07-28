//
//  CoreDataManager.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 20.06.2022.
//

import SwiftUI
import CoreData

class CoreDataManager {
  static let instance = CoreDataManager()
  let container: NSPersistentContainer
  var context: NSManagedObjectContext { container.viewContext }
  
  private init() {
    container = NSPersistentContainer(name: "CoreDataContainer")
    let description = NSPersistentStoreDescription()
    description.shouldMigrateStoreAutomatically = true
    description.shouldInferMappingModelAutomatically = true
    container.persistentStoreDescriptions.append(description)
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Error loading Core Data \(error)")
      }
    }
  }
}
