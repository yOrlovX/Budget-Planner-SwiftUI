//
//  ChooseBankView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 01.06.2022.
//

import SwiftUI

struct ChooseBankView: View {
  @State var selectedRow: BankModel?
    
  var body: some View {
      ZStack {
        Colors.background
          .ignoresSafeArea()
        VStack(spacing: 0) {
          registrationProgress
          choseBankHeader
          List {
            ForEach(banks, id: \.self) { bank in
              BankRow(rowData: bank, selectedRow: self.$selectedRow)
            }
          }
          .listStyle(.insetGrouped)
          NavigationLink(destination: ConnectionView()) {
            Text("Next")
              .frame(maxWidth: .infinity)
              .frame(height: 60)
              .background(Colors.purpleButton)
              .cornerRadius(30)
              .foregroundColor(.white)
              .padding(.horizontal, 20)
              .padding(.bottom, 30)
              .padding(.top, 20)
          }
        }
      }
      .navigationTitle("")
    }
}

extension ChooseBankView {
  private var registrationProgress: some View {
    HStack(spacing: 50) {
      VStack(spacing: 8) {
        Circle()
          .frame(width: 29, height: 29)
          .foregroundColor(Colors.cardProgress)
          .overlay {
            Image(systemName: "checkmark")
              .font(.system(size: 15, weight: .semibold))
              .foregroundColor(.white)
          }
        Text("Country")
          .font(.system(size: 12, weight: .semibold))
          .foregroundColor(Colors.grayText)
      }
      VStack(spacing: 8) {
        Circle()
          .frame(width: 29, height: 29)
          .foregroundColor(Colors.purpleButton)
          .overlay {
            Text("2")
              .font(.system(size: 15, weight: .semibold))
              .foregroundColor(.white)
          }
        Text("Bank")
          .font(.system(size: 12, weight: .semibold))
          .foregroundColor(Colors.grayText)
      }
      VStack(spacing: 8) {
        Circle()
          .frame(width: 29, height: 29)
          .foregroundColor(Colors.cardProgressCirle)
          .overlay {
            Text("3")
              .font(.system(size: 15, weight: .semibold))
              .foregroundColor(Colors.cardCircleText)
          }
        Text("Country")
          .font(.system(size: 12, weight: .semibold))
          .foregroundColor(Colors.grayText)
      }
    }
    .frame(maxWidth: .infinity)
  }
  
  private var choseBankHeader: some View {
    Text("Choose Bank")
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.leading, 20)
      .padding(.top, 20)
      .font(.system(size: 20, weight: .bold))
  }
}

struct BankRow: View {
  let rowData: BankModel
  @Binding var selectedRow: BankModel?
  var body: some View {
    HStack {
      Text(rowData.name)
        .font(.system(size: 15, weight: .medium))
        .foregroundColor(Colors.basicText)
        .padding(.vertical, 22)
        .padding(.leading, 15)
      Spacer()
      if rowData == selectedRow {
        Image(systemName: "checkmark")
          .foregroundColor(Colors.listSelectedItem)
          .padding(.trailing, 15)
      }
    }
    .listRowBackground(Colors.listBackground)
    .onTapGesture {
      self.selectedRow = rowData
    }
  }
}

struct BankModel: Identifiable, Equatable, Hashable {
  let id = UUID()
  let name: String
}

var banks: [BankModel] = [BankModel(name: "Bank of America"),
                          BankModel(name: "JPMorgan Chase Bank"),
                          BankModel(name: "Citibank"),
                          BankModel(name: "Wachovia Bank"),
                          BankModel(name: "Wells Fargo Bank"),
                          BankModel(name: "Washington Mutual Bank"),
                          BankModel(name: "U.S. Bank"),
                          BankModel(name: "SunTrust Bank"),
                          ]

struct ChooseBankView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseBankView()
    }
}

