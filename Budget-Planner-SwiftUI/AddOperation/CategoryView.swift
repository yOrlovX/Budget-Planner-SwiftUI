//
//  CategoryView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 29.07.2022.
//

import SwiftUI

struct CategoryView: View {
  @ObservedObject var operationsViewModel = OperationViewModel()
  @State var currentTab: String = "Expenses"
  @Environment(\.presentationMode) var presentationMode
  @Binding var selectedCategory: String
  
                 
    var body: some View {
      ZStack {
        Colors.background
          .ignoresSafeArea()
        VStack {
          CustomSegmentedBar()
          if currentTab == "Expenses" {
            List {
              ForEach(operationsViewModel.categories, id: \.self) { category in
                HStack {
                  Image(category.lowercased())
                  Text(category)
                  Spacer()
                  if selectedCategory == category {
                    Image(systemName: "checkmark")
                      .foregroundColor(Colors.listSelectedItem)
                      .padding(.trailing, 15)
                  }
                }
                .onTapGesture {
                  self.selectedCategory = category
                  presentationMode.wrappedValue.dismiss()
                }
                .frame(height: 56)
                .listRowBackground(Colors.listBackground)
              }
            }
          }
          else {
            List {
              ForEach(operationsViewModel.incomes, id: \.self) { income in
                HStack {
                  Image(income.lowercased())
                  Text(income)
                  Spacer()
                  if selectedCategory == income {
                    Image(systemName: "checkmark")
                      .foregroundColor(Colors.listSelectedItem)
                      .padding(.trailing, 15)
                  }
                }
                .onTapGesture {
                  self.selectedCategory = income
                  presentationMode.wrappedValue.dismiss()
                }
                .frame(height: 56)
                .listRowBackground(Colors.listBackground)
              }
            }
          }
          Spacer()
        }
        .padding(.top, 30)
      }
      .navigationBarTitle("Category")
    }
  
  @ViewBuilder
  func CustomSegmentedBar() -> some View {
     let tabs = ["Expenses", "Income"]
    HStack(spacing: 10) {
      ForEach(tabs, id: \.self) { tab in
        Text(tab)
          .font(.system(size: 13, weight: .semibold))
          .foregroundColor(currentTab == tab ? .white : Colors.statisticSegmentText)
          .frame(height: 38)
          .frame(maxWidth: .infinity )
          .background {
            if currentTab == tab {
              Capsule()
                .fill(Colors.purpleButton)
            }
          }
          .contentShape(Capsule())
          .onTapGesture {
            currentTab = tab
          }
      }
    }
    .padding(.horizontal, 18)
    .background(Colors.background)
  }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
      CategoryView(selectedCategory: .constant(""))
    }
}
