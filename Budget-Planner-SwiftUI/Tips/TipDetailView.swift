//
//  TipDetailView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 03.06.2022.
//

import SwiftUI

struct TipDetailView: View {
    var body: some View {
      ZStack {
        VStack(spacing: 11) {
          Image("detailTip")
            .resizable()
            .scaledToFit()
          Text("How to save a budget 10 tips")
            .font(.system(size: 29, weight: .bold))
          Text("We all want to save money. And whether it's by denying yourself that $4 mocha latte once a week or putting off an exotic family vacation, everyone has their own way to save. Use these money-saving tips to generate ideas about the best ways to save money in your day-to-day life:")
            .font(.system(size: 15, weight: .regular))
            .foregroundColor(Colors.grayText)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
          Spacer()
        }
      }
    }
}

struct TipDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TipDetailView()
    }
}
