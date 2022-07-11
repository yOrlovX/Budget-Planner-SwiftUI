//
//  UserViewModel.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 08.06.2022.
//

import SwiftUI
import CoreData

class UserViewModel : ObservableObject {
  @Published var savedEntities: [UserEntity] = []
  let manager = CoreDataManager.instance
  
  init() {
    retrieveUser()
  }

  func retrieveUser() {
    let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
    do {
      savedEntities = try manager.container.viewContext.fetch(request)
    } catch let error {
      print("Error fetching \(error)")
    }
  }
  
  func deleteUser() {
    for user in savedEntities {
      manager.container.viewContext.delete(user)
    }
    do {
      try manager.container.viewContext.save()
    } catch let error {
      print("Error deteting user \(error)")
    }
  }
  
  func addUser(name: String, email: String, pincode: String, currency: String, limit: Int16) {
    let newUser = UserEntity(context: manager.container.viewContext)
    newUser.name = name
    newUser.email = email
    newUser.pincode = pincode
    newUser.limit = limit
    newUser.currency = currency
    saveData()
  }

  func saveData() {
    do {
      try manager.container.viewContext.save()
      retrieveUser()
    } catch let error {
      print("Error saving \(error)")
    }
  }
}
