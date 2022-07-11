//
//  MyProgressViewStyle.swift
//  BudgetPlanner
//
//  Created by Optimus Prime on 20.04.2022.
//

import SwiftUI

struct MyProgressViewStyle: ProgressViewStyle {
  func makeBody(configuration: Configuration) -> some View {
    ProgressView(configuration)
      .accentColor(Colors.purpleButton)
      .foregroundColor(.white)
      .frame(width: 199, height: 10)
      .scaleEffect(x: 1, y: 2, anchor: .center)
      .clipShape(RoundedRectangle(cornerRadius: 6))
      .padding(.horizontal)
  }
}
