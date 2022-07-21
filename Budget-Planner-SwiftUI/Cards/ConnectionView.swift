//
//  ConnectionView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 01.06.2022.
//

import SwiftUI

struct ConnectionView: View {
  @State private var loginText: String = ""
  @State private var passwordText: String = ""
    
  var body: some View {
      ZStack {
        Colors.background
          .ignoresSafeArea()
        VStack {
          registrationProgress
          bankLabel
            .padding(.top, 20)
          textFields
            .padding(.top, 20)
          Spacer()
          securityLabel
          purpleButton
        }
      }
    }
}

extension ConnectionView {
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
          .foregroundColor(Colors.cardProgress)
          .overlay {
            Image(systemName: "checkmark")
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
          .foregroundColor(Colors.purpleButton)
          .overlay {
            Text("3")
              .font(.system(size: 15, weight: .semibold))
              .foregroundColor(.white)
          }
        Text("Country")
          .font(.system(size: 12, weight: .semibold))
          .foregroundColor(Colors.grayText)
      }
    }
    .frame(maxWidth: .infinity)
  }
  
  private var bankLabel: some View {
    VStack(spacing: 1) {
      Text("Citibank")
        .font(.system(size: 20, weight: .bold))
      Text("Ukraine")
        .font(.system(size: 15, weight: .regular))
        .foregroundColor(Colors.grayText)
    }
  }
  
  private var textFields: some View {
    VStack(spacing: 13) {
      TextField("Login", text: $loginText)
        .padding(.leading, 16)
        .frame(height: AdaptiveTextField.adaptiveHeight)
        .frame(maxWidth: .infinity)
        .background(Colors.listBackground)
        .cornerRadius(20)
        .padding(.horizontal, 20)
      TextField("Password", text: $passwordText)
        .padding(.leading, 16)
        .frame(height: AdaptiveTextField.adaptiveHeight)
        .frame(maxWidth: .infinity)
        .background(Colors.listBackground)
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
  }
  
  private var securityLabel: some View {
    VStack(spacing: 18) {
      Image("Security_announcement")
        .resizable()
        .scaledToFit()
        .frame(width: 32, height: 32)
      Text("Connection date is not available to bank employees. Date is encrypted and stored on the phone.")
        .font(.system(size: 15, weight: .regular))
        .minimumScaleFactor(0.7)
        .foregroundColor(Colors.grayText)
        .multilineTextAlignment(.center)
        .padding(20)
    }
  }
  
  private var purpleButton: some View {
    Text("Next")
      .frame(maxWidth: .infinity)
      .frame(height: 60)
      .background(Colors.purpleButton)
      .cornerRadius(30)
      .foregroundColor(.white)
      .padding(.horizontal, 20)
      .padding(.bottom, 30)
  }
}

struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView()
    }
}
