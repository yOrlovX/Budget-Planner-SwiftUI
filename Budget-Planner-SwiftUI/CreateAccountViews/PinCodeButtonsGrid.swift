//
//  PinCodeView.swift
//  BudgetPlanner
//
//  Created by Yaroslav Orlov on 01.05.2022.
//

import SwiftUI

struct PinCodeButtonsGrid: View {
  @Environment(\.presentationMode) var presentationMode
  @State var selectedItem: Int = 0
  let buttons: [Int] = [1,2,3,4,5,6,7,8,9]
  @State var password: String = ""
  @State var value: Int = 0
  let columns = Array(repeating: GridItem(.fixed(71), spacing: 32), count: 3)
  @Binding var pin: String
 
  init(pin: Binding<String>) {
    self._pin = pin
  }
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Colors.background
        .ignoresSafeArea()
      VStack {
        Spacer()
        Text("Enter Passcode")
          .font(.system(size: 20, weight: .bold))
          .foregroundColor(Colors.basicText)
        Text("New PIN")
          .font(.system(size: 15, weight: .regular))
          .foregroundColor(Colors.grayText)
          .padding()
        SegmentProgressView(newValue: $value)
        Spacer()
        LazyVGrid(columns: columns, spacing: 32) {
          ForEach(Array(zip(buttons.indices, buttons)), id: \.0) { index, item in
            Button(action: {self.selectedItem = index + 1
              self.value += 1
              print("\(selectedItem)")
              self.pin += String(selectedItem)
              if pin.count == 4 {
                presentationMode.wrappedValue.dismiss()
                print("\(pin)")
              }
            }) {
              Text("\(item)")
                .font(.system(size: 23, weight: .bold))
                .foregroundColor(selectedItem == item  ? .white : Colors.purpleButton)
                .frame(width: 71, height: 71)
                .background((selectedItem == item) ? Colors.purpleButton : Colors.listBackground )
                .cornerRadius(20)
            }
          }
        }
        Spacer()
        HStack{
          Spacer()
          Button(action: { self.value = 0
            self.selectedItem = 0
          }) {
            Text("Cancel")
              .font(.system(size: 15, weight: .regular))
              .foregroundColor(Colors.grayText)
          }
        }
        .padding(.trailing)
        Spacer()
      }
    }
  }
}

struct PinCodeView_Previews: PreviewProvider {
  static var previews: some View {
    PinCodeButtonsGrid(pin: .constant(""))
  }
}


