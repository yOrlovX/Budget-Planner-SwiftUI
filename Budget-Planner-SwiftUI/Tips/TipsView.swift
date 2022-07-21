//
//  TipsView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 03.06.2022.
//

import SwiftUI

struct TipsView: View {
  @State private var searchText: String = ""
  @State private var searching = false
  var tipsImages: [TipsModel] = TipsData.data
  let columns = Array(repeating: GridItem(.adaptive(minimum: .infinity), spacing: 10), count: 2)
    
  var body: some View {
      ZStack {
        Colors.background
          .ignoresSafeArea()
        VStack {
          Text("Tips")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding(.top, 20)
            .font(.system(size: 34, weight: .bold))
            .foregroundColor(Colors.basicText)
          SearchBar(searchText: $searchText, searching: $searching)
          ScrollView {
            LazyVGrid(columns: columns, spacing: 17) {
              ForEach(tipsImages, id: \.self) { image in
                NavigationLink(destination: TipDetailView()) {
                  Image(image.image)
                    .resizable()
                    .scaledToFit()
                    .background(Colors.listBackground)
                    .cornerRadius(20)
                }
              }
            }
            .padding(.top, 27)
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
          }
        }
      }
    }
}

struct TipsModel: Hashable {
  let image: String
}

struct TipsData {
  static let data: [TipsModel] = [TipsModel(image: "tips1"),
                                  TipsModel(image: "tips2"),
                                  TipsModel(image: "tips3"),
                                  TipsModel(image: "tips4"),
                                  TipsModel(image: "tips5"),
                                  TipsModel(image: "tips6")]
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView()
    }
}
