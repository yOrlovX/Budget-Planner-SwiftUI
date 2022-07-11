//
//  ActionsView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 30.05.2022.
//

import SwiftUI

struct ActionsView: View {
  @ObservedObject var operationViewModel = OperationViewModel()
  @State private var searchText = ""
  
    var body: some View {
      ZStack {
        Colors.background
          .ignoresSafeArea()
          VStack(spacing: 15) {
            searchBar
            List {
              ForEach(operationViewModel.savedOperations, id: \.self) { operation in
                ActionsRow(name: operation.category ?? "", image: operation.category?.lowercased() ?? "", description: operation.note ?? "", price: operation.sum , currency: operation.currency ?? "", date: operation.date ?? Date())
              }
              .onDelete(perform: operationViewModel.deleteOperation(indexSet:))
            }
            .cornerRadius(20)
          }
      }
      .toolbar {
          EditButton()
      }
    }
}

extension ActionsView {
  private var searchBar: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .padding(.leading, 14)
      Text("Search\(searchText)")
        .foregroundColor(Colors.grayText)
      Spacer()
    }
    .frame(height: 44)
    .frame(maxWidth: .infinity)
    .background(.white)
    .cornerRadius(20)
    .padding(.horizontal, 20)
  }
}

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
        ActionsView()
    }
}
