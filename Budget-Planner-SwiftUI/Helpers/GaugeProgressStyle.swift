//
//  GaugeProgressStyle.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 28.05.2022.
//

import SwiftUI

struct GaugeProgressStyle: ProgressViewStyle {
  var strokeColor = Color.blue
  var strokeWidth = 25.0
  
  func makeBody(configuration: Configuration) -> some View {
    let fractionCompleted = configuration.fractionCompleted ?? 0
    return ZStack {
      Circle()
        .trim(from: 0, to: fractionCompleted)
        .stroke(Colors.purpleButton, style: StrokeStyle(lineWidth: 15, lineCap: .round))
        .rotationEffect(.degrees(-90))
    }
  }
}

