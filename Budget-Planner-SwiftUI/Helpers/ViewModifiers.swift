//
//  ViewModifiers.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 13.07.2022.
//

import Foundation
import SwiftUI

struct UserProfileNameModifier : ViewModifier {
  func body(content: Content) -> some View {
    content
      .multilineTextAlignment(.trailing)
      .font(.system(size: 15, weight: .medium))
      .padding(.trailing, 15)
      .padding(.vertical, 20)
      .foregroundColor(Colors.grayText)
  }
}

struct UserProfileTitleModifier : ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.system(size: 15, weight: .medium))
      .padding(.leading, 15)
      .padding(.vertical, 20)
      .foregroundColor(Colors.basicText)
  }
}

struct UserProfilePickerModifier : ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(.trailing, 15)
      .multilineTextAlignment(TextAlignment.trailing)
      .accentColor(.gray)
      .pickerStyle(.menu)
  }
}
