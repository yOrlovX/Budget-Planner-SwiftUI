//
//  RegistrationDoneView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 25.05.2022.
//

import SwiftUI

struct RegistrationDoneView: View {
    
  var body: some View {
      NavigationLink(destination: CustomTabBar()) {
        ZStack {
          Colors.background
            .ignoresSafeArea(.all)
          VStack {
            Image("done")
              .resizable()
              .scaledToFit()
              .frame(width: 120, height: 115)
              
            Text("Congratulations!")
              .font(.system(size: 15, weight: .bold))
              .padding(5)
            
            Text("You have registered")
              .font(.system(size: 15, weight: .regular))
              .foregroundColor(Colors.grayText)
          }
        }
      }
    }
}

struct RegistrationDoneView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationDoneView()
    }
}
