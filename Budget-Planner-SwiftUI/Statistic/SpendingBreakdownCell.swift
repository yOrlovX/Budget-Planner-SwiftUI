//
//  SpendingBreakdownCell.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 07.06.2022.
//

import SwiftUI

struct SpendingBreakdownCell: View {
  
  var image: String
  var name: String
  var sum: Int16
  var progress: Double
  
    var body: some View {
        VStack {
          ZStack {
            ProgressView(value: progress, total: 1)
              .progressViewStyle(SemiCircleProgressViewStyle())
            Image(image)
              .resizable()
              .scaledToFit()
              .frame(width: 24, height: 24)
          }
          VStack(spacing: 5) {
            Text(name)
              .font(.system(size: 12, weight: .semibold))
            .foregroundColor(Colors.grayText)
            Text("\(sum)")
              .font(.system(size: 15, weight: .semibold))
              .foregroundColor(Colors.basicText)
          }
          .padding(.top, -10)
          .padding(.bottom, 15)
        }
        .background(Colors.listBackground)
        .frame(height: 145)
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

