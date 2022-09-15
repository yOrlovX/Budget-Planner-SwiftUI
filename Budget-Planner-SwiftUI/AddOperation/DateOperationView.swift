//
//  DateOpetationView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 01.08.2022.
//

import SwiftUI

struct DateOperationView: View {
  @Binding var selectedDate: Date
    var body: some View {
      ZStack {
        Colors.background
          .ignoresSafeArea(.all)
        DatePicker("", selection: $selectedDate,displayedComponents: .date)
        .foregroundColor(Colors.basicText)
        .font(.system(size: 15, weight: .medium))
        .listRowBackground(Colors.listBackground)
        .datePickerStyle(.wheel)
      }
    }
}

struct DateOperationView_Previews: PreviewProvider {
    static var previews: some View {
      DateOperationView(selectedDate: .constant(Date()))
    }
}
