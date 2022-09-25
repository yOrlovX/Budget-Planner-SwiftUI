//
//  AddOperationView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 30.05.2022.
//

import SwiftUI

struct AddOperationView: View {
  @ObservedObject var operationViewModel = OperationViewModel()
  @State private var operationSum: String = ""
  @State private var descriptionText: String = ""
  @State private var selectedCurrency = ""
  @State private var selectedCategory = ""
  @State private var selectedDate = Date()
  @State private var showsDatePicker = false
  @State private var isValidate: Bool = false
  var cellHorizontalPadding: CGFloat = UIScreen.main.bounds.width - 70
  
  var body: some View {
    ZStack {
      Colors.background
        .ignoresSafeArea()
      ScrollView {
        VStack {
          ZStack {
            Image("addOperation")
              .resizable()
              .scaledToFit()
              .padding(25)
          }
          .frame(width: 120, height: 120)
          .background(Colors.listBackground)
          .cornerRadius(25)
          Text("Add operation")
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(Colors.basicText)
          TextField("$ 0,00", text: $operationSum)
            .font(.system(size: 21, weight: .semibold))
            .multilineTextAlignment(.center)
            .frame(height: 67)
            .frame(maxWidth: .infinity)
            .background(Colors.listBackground)
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .onChange(of: operationSum) { newValue in
              isDataValidate()
            }
          VStack(spacing: 0) {
            NavigationLink(destination: CategoryView(selectedCategory: $selectedCategory)) {
              OperationCell(title: "Category") {
                if selectedCategory.isEmpty {
                  Image(systemName: "chevron.right")
                } else {
                  Text(selectedCategory)
                }
              }
            }
            Divider()
              .frame(width: cellHorizontalPadding)
            NavigationLink(destination: CurrencyView(selectedCurrency: $selectedCurrency)) {
              OperationCell(title: "Currency") {
                if selectedCurrency.isEmpty {
                  Image(systemName: "chevron.right")
                } else {
                  Text(selectedCurrency)
                }
              }
            }
            Divider()
              .frame(width: cellHorizontalPadding)
            NavigationLink(destination: DateOperationView(selectedDate: $selectedDate)) {
              OperationCell(title: "Date") {
                HStack {
                  Text(dateFormatter.string(from: selectedDate))
                  Image(systemName: "chevron.right")
                }
              }
            }
          }
          .background(Colors.listBackground)
          .cornerRadius(20)
          .padding(.horizontal, 20)
          TextField("Note", text: $descriptionText)
            .padding(.top, 15)
            .padding(.leading, 15)
            .frame(height: 112, alignment: .topLeading)
            .frame(maxWidth: .infinity)
            .background(Colors.listBackground)
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .onChange(of: descriptionText) { newValue in
              isDataValidate()
            }
          Button(action: {
            operationViewModel.addOperation(
              category: selectedCategory,
              currency: selectedCurrency,
              date: selectedDate,
              note: descriptionText,
              sum: checkNegativeOperationSum())
          })
          {
            Text("Add")
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(isValidate ? Colors.purpleButton : Colors.grayText)
            .cornerRadius(30)
            .padding(.horizontal, 20)
            .padding(.top, 30)
          }
          .disabled(isValidate == false)
          .padding(.bottom, 100)
        }
      }
    }
  }
  
  func isDataValidate() {
    if operationSum.count > 0 && descriptionText.count > 0 {
      isValidate = true
    } else {
      isValidate = false
    }
  }
  
  func checkNegativeOperationSum() -> Int16 {
    var newSum: Int16 = 0
    for category in operationViewModel.categories {
      if selectedCategory == category {
        newSum = Int16(operationSum) ?? 0
      } else {
        return Int16(operationSum) ?? 0
      }
    }
    return -newSum
  }
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE d MMM"
    return formatter
  }
}

struct AddOperationView_Previews: PreviewProvider {
  static var previews: some View {
    AddOperationView()
  }
}
