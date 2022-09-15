//
//  OperationCell.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 31.07.2022.
//

import SwiftUI

struct OperationCell<Content>: View where Content : View {
  let title: String
  let content: () -> Content
  
  init(title: String, @ViewBuilder content: @escaping () -> Content) {
    self.title = title
    self.content = content
  }
    var body: some View {
      HStack {
        Text(title)
          .foregroundColor(Colors.basicText)
          .font(.system(size: 15, weight: .medium))
          .padding(.vertical, 22)
          .padding(.leading, 15)
        Spacer()
        content()
          .foregroundColor(Colors.basicText)
          .font(.system(size: 15, weight: .medium))
          .padding(.vertical, 22)
          .padding(.trailing, 15)
      }
    }
}
