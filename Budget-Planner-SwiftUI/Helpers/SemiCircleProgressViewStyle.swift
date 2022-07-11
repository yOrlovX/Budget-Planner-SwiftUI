//
//  SemiCircleProgressViewStyle.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 07.06.2022.
//

import SwiftUI

struct SemiCircleProgressViewStyle: ProgressViewStyle {
  var strokeColor = Color.blue
  var strokeWidth = 25.0
  var style = StrokeStyle()
  
  func makeBody(configuration: Configuration) -> some View {
    let fractionCompleted = configuration.fractionCompleted ?? 0
    
    return ZStack {
      Semicircle()
        .trim(from: 0, to: fractionCompleted)
        .stroke(Colors.purpleButton, style: StrokeStyle(lineWidth: 5, lineCap: .round))
          Semicircle()
            .stroke(.gray.opacity(0.2), style: StrokeStyle(lineWidth: 5, lineCap: .round))
    }
  }
}



