//
//  AdaptiveFonts.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 19.07.2022.
//

import Foundation
import UIKit

struct AdaptiveFonts {
  static var screen = UIScreen.main.bounds.height
  static var totalSumFont: CGFloat = screen < 896 ? 24 : 40
  static var spentTodayFont: CGFloat = screen < 896 ? 14 : 16
  static var balanceTodayFont: CGFloat = screen < 896 ? 14 : 16
  static var userLimitFont: CGFloat = screen < 896 ? 16 : 23
}
