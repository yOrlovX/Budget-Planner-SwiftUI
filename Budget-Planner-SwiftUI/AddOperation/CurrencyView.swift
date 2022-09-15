//
//  CurrencyView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 31.07.2022.
//

import SwiftUI

struct CurrencyView: View {
  @Environment(\.presentationMode) var presentationMode
  @Binding var selectedCurrency: String
  let currencies = ["$ Dollar","£ Pound","€ Euro","¥ Yen"]
  
    var body: some View {
      ZStack {
        Colors.background
          .ignoresSafeArea(.all)
        List{
          ForEach(currencies, id: \.self) { currency in
            HStack {
                Image(currency.lowercased())
                Text(currency)
              Spacer()
              if selectedCurrency == currency {
                Image(systemName: "checkmark")
                  .foregroundColor(Colors.listSelectedItem)
                  .padding(.trailing, 15)
              }
            }
            .onTapGesture {
              self.selectedCurrency = currency
              presentationMode.wrappedValue.dismiss()
            }
            .frame(height: 56)
            .listRowBackground(Colors.listBackground)
          }
        }
      }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
      CurrencyView(selectedCurrency: .constant(""))
    }
}
