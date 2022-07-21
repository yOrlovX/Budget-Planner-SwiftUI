//
//  SpendingBreakdownView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 07.06.2022.
//

import SwiftUI

struct SpendingBreakdownView: View {
  let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
  
    var body: some View {
      VStack {
        Text("Spending Breakdown")
          .font(.system(size: 20, weight: .bold))
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.bottom, 17)
          .foregroundColor(Colors.basicText)
        LazyVGrid(columns: columns, spacing: 10) {
          ForEach(operationsData, id: \.self) { operation in
            SpendingBreakdownCell(operationImage: operation.image, operationName: operation.name, operationPrice: operation.price, operationProgress: operation.progress)
          }
        }
      }
      .background(Colors.background)
      .padding(.horizontal, 20)
    }
}

let operationsData: [OperationCellModel] = [OperationCellModel(name: "Travel", image: "travel", price: "$ 225", progress: 0.6), OperationCellModel(name: "Food", image: "food", price: "$ 23", progress: 0.2),
                                            OperationCellModel(name: "Sport", image: "sport", price: "$ 10", progress: 0.1),OperationCellModel(name: "Shoping", image: "shopping", price: "$ 0", progress: 0.0),OperationCellModel(name: "Cash", image: "cash", price: "$ 0", progress: 0.0),OperationCellModel(name: "Education", image: "education", price: "$ 245", progress: 0.8)]

struct SpendingBreakdownView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingBreakdownView()
    }
}

