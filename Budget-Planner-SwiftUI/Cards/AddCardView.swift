//
//  AddCardView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 30.05.2022.
//

import SwiftUI

struct AddCardView: View {
    var body: some View {
        ZStack {
          Colors.background
            .ignoresSafeArea()
          VStack(spacing: 11) {
            Text("Cards")
              .font(.system(size: 34, weight: .bold))
              .frame(maxWidth: .infinity, alignment: .leading)
            Text("Add your cards to see expenses and income on them")
              .font(.system(size: 23, weight: .regular))
              .multilineTextAlignment(.leading)
              .foregroundColor(Colors.grayText)
            NavigationLink(destination: ChooseCountryView()) {
              VStack {
                Image("addCard")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 70, height: 76)
                Text("Add your first card")
              }
              .frame(maxWidth: .infinity)
              .padding(.vertical, 40)
              .background(Colors.listBackground)
              .cornerRadius(10)
            }
            Spacer()
          }
          .padding(.top, 80)
          .padding(.horizontal, 20)
        }
        .navigationTitle("")
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView()
    }
}
