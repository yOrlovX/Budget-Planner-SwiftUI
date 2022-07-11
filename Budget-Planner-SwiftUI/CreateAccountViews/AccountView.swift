//
//  AccountView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 24.05.2022.
//

import SwiftUI

struct AccountView: View {
  @StateObject var viewModel = UserViewModel()
  @State var name: String = ""
  @State var email: String = ""
  @State private var selectedCurrency = "USD"
  @State private var selectedLimit = 1000
  @State private var showFaceId = true
  @Binding var isValidate: Bool
  @State var pin: String = ""
  @State private var isSecured: Bool = true
  @State var showPinPool: Bool = false
  @Binding var isAccountCreated: Bool
  var valutes = ["USD", "EUR", "GBR", "GRN"]
  var moneyLimit = [1000, 2000, 3000, 4000]
  var cellHeight: CGFloat = 60
  @Binding var onboardingState: Int
  
  var body: some View {
    ScrollView {
      ZStack(alignment: .bottom) {
          VStack() {
            logoWithText
            VStack(spacing: 1) {
              accountCell
                .onChange(of: name) { newValue in
                  checkAccountInputs()
                }
              mailCell
                .onChange(of: email) { newValue in
                  checkAccountInputs()
                }
              currencyCell
              dailyLimitCell
              faceIdCell
              setPinCell
            }
            .overlay(
              RoundedRectangle(cornerRadius: 25)
                .stroke(Color.white, lineWidth: 1)
            )
            .background(.white)
            .cornerRadius(25)
            .padding()
            VStack {
              createAccountButton
              HStack(spacing: 30) {
                Button(action: { viewModel.deleteUser()}) {
                  Text("Delete")
                }
                .padding(.top, 30)
              }
            }
            .padding(.top, 70)
          }
      }
      .fullScreenCover(isPresented: $showPinPool) {
          PinCodeButtonsGrid(pin: $pin)
      }
    }
  }
}

extension AccountView {
  
  private var logoWithText: some View {
    VStack(spacing: 0) {
      Image("logo")
        .resizable()
        .scaledToFit()
        .frame(width: 115, height: 115)
      Text("Get Started")
        .font(.system(size: 20, weight: .bold))
      Text("It only takes a minute to start taking hold \nof your finances")
        .font(.system(size: 15, weight: .regular))
        .multilineTextAlignment(.center)
        .foregroundColor(Colors.grayText)
    }
  }
  
  private var accountCell: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Name:")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
        Spacer()
        TextField("None", text: $name)
          .multilineTextAlignment(TextAlignment.trailing)
          .padding(.trailing, 15)
      }
      .frame(height: cellHeight)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
  
  private var mailCell: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Email:")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
        Spacer()
        TextField("None", text: $email)
          .multilineTextAlignment(TextAlignment.trailing)
          .padding(.trailing, 15)
      }
      .frame(height: cellHeight)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
  
  private var currencyCell: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Currency")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
        Spacer()
        HStack {
          Picker("", selection: $selectedCurrency) {
            ForEach(valutes, id: \.self) {
              Text($0)
            }
          }
          .padding(.trailing, 15)
          .multilineTextAlignment(TextAlignment.trailing)
          .accentColor(.gray)
          .pickerStyle(.menu)
        }
      }
      .frame(height: cellHeight)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
  
  private var dailyLimitCell: some View {
    VStack(spacing:0) {
      HStack {
        Text("Daily limit")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
        Spacer()
        HStack {
          Picker("", selection: $selectedLimit) {
            ForEach(moneyLimit, id: \.self) {
              Text("\($0)")
            }
          }
          .padding(.trailing, 15)
          .multilineTextAlignment(TextAlignment.trailing)
          .accentColor(.gray)
          .pickerStyle(.menu)
        }
      }
      .frame(height: cellHeight)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
  
  private var faceIdCell: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Use FaceID")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
        Spacer()
        Toggle("", isOn: $showFaceId)
          .padding(.trailing, 15)
      }
      .frame(height: cellHeight)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
  
  private var setPinCell: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Set your pin")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
        Spacer()
        Group {
          if isSecured {
            SecureField("", text: $pin)
          } else {
            TextField("", text: $pin)
          }
        }
        .onTapGesture {
          if pin.count < 4 {
            showPinPool.toggle()
          }
        }
        .multilineTextAlignment(TextAlignment.trailing)
        .padding(.vertical, 20)
        Button(action: {isSecured.toggle()}) {
          Image(systemName: self.isSecured ? "eye.slash" : "eye")
            .padding(.trailing, 15)
            .accentColor(.gray)
        }
      }
      .frame(height: cellHeight)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
  
  private var createAccountButton: some View {
    Text("Create Account")
      .font(.system(size: 15, weight: .bold))
      .foregroundColor(.white)
      .frame(height: 60)
      .frame(maxWidth: .infinity)
      .background(isValidate ? Colors.purpleButton : Colors.accountGrayButton)
      .cornerRadius(30)
      .padding(.horizontal, 20)
      .animation(nil)
      .onTapGesture {
        if isValidate {
          viewModel.addUser(name: name, email: email, pincode: pin, currency: selectedCurrency, limit: Int16(selectedLimit))
         onboardingState += 1
        }
      }
  }
}
extension AccountView {
  func checkAccountInputs() {
    if name.count > 3 && email.count > 3 && pin.count > 3 {
      isValidate = true
    } else {
      isValidate = false
    }
  }
}

struct AccountView_Previews: PreviewProvider {
  static var previews: some View {
    AccountView(isValidate: .constant(false), isAccountCreated: .constant(false), onboardingState: .constant(1))
  }
}
