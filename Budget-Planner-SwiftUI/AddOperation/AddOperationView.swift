//
//  AddOperationView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 30.05.2022.
//

import SwiftUI

struct AddOperationView: View {
  @ObservedObject var operationViewModel = OperationViewModel()
  @State var operationSum: String = ""
  @State var descriptionText: String = ""
  @State private var selectedCurrency = ""
  @State private var selectedCategory = ""
  @State private var selectedDate = Date()
  @State var showsDatePicker = false
  @State var isValidate: Bool = false
  let categories = ["Shopping","Travel","Food","Medicine","Cash","Sport","Education","Accommodation","Other"]
  let currencies = ["$ Dollar","£ Pound","€ Euro","¥ Yen"]
  
  var body: some View {
    ZStack {
      Colors.background
        .ignoresSafeArea()
      ScrollView {
        VStack {
          Image("addOperation")
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 115)
          Text("Add operation")
            .font(.system(size: 20, weight: .bold))
          TextField("$ 0,00", text: $operationSum)
            .font(.system(size: 21, weight: .semibold))
            .multilineTextAlignment(.center)
            .frame(height: 67)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .onChange(of: operationSum) { newValue in
              isDataValidate()
            }
          List {
              Picker("Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                  HStack {
                    if selectedCategory != category {
                      Image(category.lowercased())
                      Text(category)
                    } else {
                      Text(category)
                    }
                  }
                }
              }
              .foregroundColor(.black)
              .font(.system(size: 15, weight: .medium))
              Picker("Currency", selection: $selectedCurrency) {
                ForEach(currencies, id: \.self) { currency in
                  HStack {
                    if selectedCurrency != currency {
                      Image(currency.lowercased())
                      Text(currency)
                    } else {
                      Text(currency)
                    }
                  }
                }
              }
              .foregroundColor(.black)
              .font(.system(size: 15, weight: .medium))
              
                DatePicker("Date", selection: $selectedDate,displayedComponents: .date)
                .foregroundColor(.black)
                .font(.system(size: 15, weight: .medium))
          }
          .listStyle(.insetGrouped)
          .frame(height: 208)
          TextField("Note", text: $descriptionText)
            .padding(.top, 15)
            .padding(.leading, 15)
            .frame(height: 112, alignment: .topLeading)
            .frame(maxWidth: .infinity)
            .background(.white)
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
              sum: Int16(operationSum) ?? 0)
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
          .padding(.bottom, 50)
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
}

struct AddOperationView_Previews: PreviewProvider {
  static var previews: some View {
    AddOperationView()
  }
}
