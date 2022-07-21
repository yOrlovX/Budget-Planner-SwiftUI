//
//  IntroView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 24.05.2022.
//

import SwiftUI

struct IntroView: View {
  @ObservedObject var viewModel = UserViewModel()
  @State private var currentUserSignedIn: Bool = false
  
    var body: some View {
      ZStack {
        Colors.background
          .ignoresSafeArea()
        if currentUserSignedIn || !viewModel.savedEntities.isEmpty {
          CustomTabBar()
        } else {
          OnboardingView(currentUserSignedIn: $currentUserSignedIn)
        }
      }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
