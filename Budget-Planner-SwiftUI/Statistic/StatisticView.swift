//
//  StatisticView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 30.05.2022.
//

import SwiftUI

struct StatisticView: View {
  var dayArray: [String] = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
  var limitArray: [String] = ["$ 1200","$ 2400","$ 3600","$ 4800","$ 6000"]
  var chartValues: [CGFloat] = [10, 20, 30, 40, 50, 60]
  
    var body: some View {
        HStack {
            VStack(spacing: 10) {
              ForEach(limitArray.reversed(), id: \.self) { limit in
                Text(limit)
                  .font(.system(size: 12, weight: .semibold))
              }
            }
            .background(.yellow)
            .frame(height: 134)
          ForEach(dayArray, id: \.self) { day in
            VStack {
              Rectangle()
                .fill(Colors.purpleButton)
                .frame(width: 10, height: 50)
                .cornerRadius(20)
              Text(day)
                .font(.system(size: 12, weight: .semibold))
                .frame(height: 20)
            }
          }
        }
        .background(.green)
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}
