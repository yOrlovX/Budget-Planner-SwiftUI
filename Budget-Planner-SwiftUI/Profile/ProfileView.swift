//
//  ProfileView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 26.05.2022.
//

import SwiftUI
import UIKit

struct ProfileView: View {
  @StateObject var viewModel = UserViewModel()
  
  var body: some View {
    ZStack {
      Colors.background
        .ignoresSafeArea()
      ScrollView {
        VStack {
            VStack {
              ForEach(viewModel.savedEntities) { entity in
                Image("userImage")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 120, height: 115)
                  .clipShape(Circle())
                Text(entity.name ?? "")
                  .font(.system(size: 20, weight: .bold))
              }
            }
            VStack(spacing: 0) {
              ForEach(viewModel.savedEntities) { entity in
                NameCell(name: entity.name ?? "")
                EmailCell(email: entity.email ?? "")
                CurrencyCell(currency: entity.currency ?? "")
                DailyLimitCell(dailyLimit: entity.limit)
                FaceIdCell()
                PinCodeCell(pin: entity.pincode ?? "")
                NotificationCell()
                NavigationLink(destination: AddMemberView()) {
                  AddMemberCell()
                }
              }
            }
            .background(.white)
            .frame(width: UIScreen.main.bounds.width - 40)
            .cornerRadius(15)
          Spacer()
          Spacer()
          Button(action: {viewModel.deleteUser()}) {
            Text("Change user data")
          }
        }
      }
    }
    .navigationTitle("")
  }
}

struct NameCell: View {
  var name: String
  init(name: String) {
    self.name = name
  }
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Name:")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
          .padding(.vertical, 20)
          .foregroundColor(.black)
        Spacer()
        Text(name)
          .font(.system(size: 15, weight: .medium))
          .padding(.trailing, 15)
          .padding(.vertical, 20)
          .foregroundColor(Colors.grayText)
      }
      .frame(height: 60)
      .foregroundColor(.white)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
}

struct EmailCell: View {
  var email: String
  init(email: String) {
    self.email = email
  }
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Email:")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
          .padding(.vertical, 20)
          .foregroundColor(.black)
        Spacer()
        Text(email)
          .font(.system(size: 15, weight: .medium))
          .padding(.trailing, 15)
          .padding(.vertical, 20)
          .foregroundColor(Colors.grayText)
      }
      .frame(height: 60)
      .foregroundColor(.white)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
}

struct CurrencyCell: View {
  var currency: String
  init(currency: String) {
    self.currency = currency
  }
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Currency:")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
          .padding(.vertical, 20)
          .foregroundColor(.black)
        Spacer()
        Text(currency)
          .font(.system(size: 15, weight: .medium))
          .padding(.trailing, 15)
          .padding(.vertical, 20)
          .foregroundColor(Colors.grayText)
      }
      .frame(height: 60)
      .foregroundColor(.white)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
}

struct DailyLimitCell: View {
  var dailyLimit: Int16
  init(dailyLimit: Int16) {
    self.dailyLimit = dailyLimit
  }
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text("DailyLimit:")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
          .padding(.vertical, 20)
          .foregroundColor(.black)
        Spacer()
        Text("\(dailyLimit)")
          .font(.system(size: 15, weight: .medium))
          .padding(.trailing, 15)
          .padding(.vertical, 20)
          .foregroundColor(Colors.grayText)
      }
      .frame(height: 60)
      .foregroundColor(.white)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
}

struct FaceIdCell: View {
  @State private var showFaceId = true
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Use FaceID")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
          .padding(.vertical, 20)
          .foregroundColor(.black)
        Spacer()
        Toggle("", isOn: $showFaceId)
          .padding(.trailing, 15)
      }
      .frame(height: 60)
      .foregroundColor(.white)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
}

struct PinCodeCell: View {
  @State private var isSecured: Bool = true
  @State var showPinPool: Bool = false
  var pin: String
  init(pin: String) {
    self.pin = pin
  }
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Your pin")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
          .padding(.vertical, 20)
          .foregroundColor(.black)
        Spacer()
        HStack {
          Spacer()
          Text(isSecured ? "****" : pin)
            .font(.system(size: 15, weight: .medium))
            .foregroundColor(Colors.grayText)
            .onTapGesture {
              showPinPool.toggle()
            }
            .multilineTextAlignment(TextAlignment.trailing)
            .padding(.vertical, 20)
          Button(action: {isSecured.toggle()}) {
            Image(systemName: self.isSecured ? "eye.slash" : "eye")
              .padding(.trailing, 15)
              .foregroundColor(.black)
          }
        }
      }
      .frame(height: 60)
      .foregroundColor(.white)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
}

struct NotificationCell: View {
  @State private var showNotifications = true
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Use FaceID")
          .font(.system(size: 15, weight: .medium))
          .padding(.leading, 15)
          .padding(.vertical, 20)
          .foregroundColor(.black)
        Spacer()
        Toggle("", isOn: $showNotifications)
          .padding(.trailing, 15)
      }
      .frame(height: 60)
      .foregroundColor(.white)
      Divider()
        .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
}

struct AddMemberCell: View {
  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 7) {
        Image(systemName: "person.badge.plus")
          .resizable()
          .frame(width: 26, height: 22)
          .foregroundColor(Colors.purpleButton)
          .padding(.leading, 15)
        Text("Add a family member")
          .font(.system(size: 15, weight: .semibold))
          .foregroundColor(Colors.purpleButton)
        Spacer()
      }
      .frame(height: 60)
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}

