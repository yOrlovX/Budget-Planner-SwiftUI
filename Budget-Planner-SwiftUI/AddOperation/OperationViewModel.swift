//
//  OperationViewModel.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 16.06.2022.
//

import SwiftUI
import CoreData

class OperationViewModel : ObservableObject {
  @Published var savedOperations: [OperationEntity] = []
  @Published var categories = ["Shopping","Travel","Food","Medicine","Cash","Sport","Education","Accommodation","Other"]
  @Published var incomes = ["Premium", "Salary", "Gift", "Sales", "Other"]
  let manager = CoreDataManager.instance
  
  init() {
    retrieveOperation()
  }
    
  func retrieveOperation() {
    let request = NSFetchRequest<OperationEntity>(entityName: "OperationEntity")
    do {
      savedOperations = try manager.container.viewContext.fetch(request)
    } catch let error {
      print("Error fetching \(error)")
    }
  }
    
  func totalSumOfOperations() -> Int16 {
    savedOperations.reduce(0) { $0 + $1.sum }
  }
    
  func addOperation(category: String, currency: String, date: Date, note: String, sum: Int16) {
    let newOperation = OperationEntity(context: manager.container.viewContext)
    newOperation.category = category
    newOperation.currency = currency
    newOperation.date = date
    newOperation.note = note
    newOperation.sum = sum
    saveData()
  }
  
  func deleteOperation(indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    let operation = savedOperations[index]
    manager.container.viewContext.delete(operation)
    saveData()
  }
    
  func saveData() {
    do {
      try manager.container.viewContext.save()
      retrieveOperation()
    } catch let error {
      print("Error saving \(error)")
    }
  }
}

//Multiple NSEntityDescriptions claim the NSManagedObject subclass
//solved error message
public extension NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
