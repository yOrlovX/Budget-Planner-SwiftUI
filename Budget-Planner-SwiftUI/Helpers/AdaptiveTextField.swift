//
//  AdaptiveTextField.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 21.07.2022.
//

import Foundation

import UIKit

struct AdaptiveTextField {
  static var screen = UIScreen.main.bounds.height
  static var adaptiveHeight: CGFloat = screen < 896 ? 50 : 70
}
