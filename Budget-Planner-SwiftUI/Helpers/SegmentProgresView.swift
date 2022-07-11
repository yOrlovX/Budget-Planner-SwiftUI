//
//  SegmentProgresView.swift
//  BudgetPlanner
//
//  Created by Optimus Prime on 02.05.2022.
//

import SwiftUI

struct SegmentProgressView: View {
  
  @Binding var newValue : Int
  var value: Int = 1
  var maximum: Int = 4
  var height: CGFloat = 10
  var spacing: CGFloat = 26
  var selectedColor: Color = Colors.purpleButton
  var unselectedColor: Color = Colors.grayButton.opacity(0.3)
  
  var body: some View {
    HStack(spacing: spacing) {
      ForEach(0 ..< maximum) { index in
        Circle()
          .frame(width: 13, height: 13)
          .foregroundColor(index < self.newValue ? self.selectedColor : self.unselectedColor)
      }
    }
  }
}

struct SegmentProgresView_Previews: PreviewProvider {
    static var previews: some View {
      SegmentProgressView(newValue: .constant(3))
    }
}
