//
//  SpendingBreakdownCell.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 07.06.2022.
//

import SwiftUI

struct SpendingBreakdownCell: View {
  @State private var progressValue = 0.3
  var operationImage: String
  var operationName: String
  var operationPrice: String
  var operationProgress: Double
  
  init(operationImage: String, operationName: String, operationPrice: String, operationProgress: Double) {
    self.operationImage = operationImage
    self.operationName = operationName
    self.operationPrice = operationPrice
    self.operationProgress = operationProgress
  }
    var body: some View {
        VStack {
          ZStack {
            ProgressView(value: operationProgress, total: 1)
              .progressViewStyle(SemiCircleProgressViewStyle())
            Image(operationImage)
              .resizable()
              .scaledToFit()
              .frame(width: 24, height: 24)
          }
          VStack(spacing: 5) {
            Text(operationName)
              .font(.system(size: 12, weight: .semibold))
            .foregroundColor(Colors.grayText)
            Text(operationPrice)
              .font(.system(size: 15, weight: .semibold))
            
          }
          .padding(.top, -10)
          .padding(.bottom, 15)
        }
        .frame(height: 145)
        .background(.white)
        .cornerRadius(20)
    }
}

struct OperationCellModel : Identifiable, Hashable {
  let id = UUID()
  let name: String
  let image: String
  let price: String
  var progress: Double
}

