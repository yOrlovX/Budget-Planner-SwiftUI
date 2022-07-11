//
//  Budget_Planner_SwiftUIApp.swift
//  Budget-Planner-SwiftUI
//
//  Created by Optimus Prime on 19.05.2022.
//

import SwiftUI

@main
struct Budget_Planner_SwiftUIApp: App {
  
  init() { UITableView.appearance().backgroundColor = .clear }
    var body: some Scene {
        WindowGroup {
          IntroView()
        }
    }
}
