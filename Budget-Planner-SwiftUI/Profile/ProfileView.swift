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
  @State private var changeData: Bool = false
  @State private var updatedName: String = ""
  @State private var updatedEmail: String = ""
  @State private var updatedCurrency: String = "USD"
  @State private var updatedLimit = 1000
  @State private var showFaceId = true
  @State private var isSecured: Bool = true
  @State private var showPinPool: Bool = false
  @State private var updatedPin: String = ""
  @State private var showNotifications = true
  @State private var showAlert: Bool = false
  
  var valutes = ["USD", "EUR", "GBR", "GRN"]
  var moneyLimit = [1000, 2000, 3000, 4000]
  
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
                .foregroundColor(Colors.basicText)
            }
          }
          VStack(spacing: 0) {
            ForEach(viewModel.savedEntities) { entity in
              Cell(title: "Name:") {
                if changeData {
                  TextField("\(entity.name ?? "")", text: $updatedName)
                    .modifier(UserProfileNameModifier())
                } else {
                  Text("\(entity.name ?? "")")
                    .modifier(UserProfileNameModifier())
                }
              }
              Cell(title: "Email:") {
                if changeData {
                  TextField("\(entity.email ?? "")", text: $updatedEmail)
                    .modifier(UserProfileNameModifier())
                } else {
                  Text("\(entity.email ?? "")")
                    .modifier(UserProfileNameModifier())
                }
              }
              Cell(title: "Currency:") {
                if changeData {
                  Picker("", selection: $updatedCurrency) {
                    ForEach(valutes, id: \.self) {
                      Text($0)
                    }
                  }
                  .modifier(UserProfilePickerModifier())
                } else {
                  Text("\(entity.currency ?? "")")
                    .modifier(UserProfileNameModifier())
                }
              }
              Cell(title: "Limit:") {
                if changeData {
                  Picker("", selection: $updatedLimit) {
                    ForEach(moneyLimit, id: \.self) {
                      Text("\($0)")
                    }
                  }
                  .modifier(UserProfilePickerModifier())
                } else {
                  Text("\(entity.limit)")
                    .modifier(UserProfileNameModifier())
                }
              }
              Cell(title: "Use FaceID") {
                Toggle("", isOn: $showFaceId)
                  .padding(.trailing, 15)
                  .tint(Colors.toggleColor)
              }
              Cell(title: "Your pin") {
                if changeData {
                  TextField("\(entity.pincode ?? "")", text: $updatedPin)
                    .modifier(UserProfileNameModifier())
                } else {
                  HStack {
                    Spacer()
                    Text(isSecured ? "****" : entity.pincode ?? "")
                      .font(.system(size: 15, weight: .medium))
                      .foregroundColor(Colors.grayText)
                      .onTapGesture {
                      }
                      .multilineTextAlignment(TextAlignment.trailing)
                      .padding(.vertical, 20)
                    Button(action: {isSecured.toggle()}) {
                      Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .padding(.trailing, 15)
                        .foregroundColor(Colors.basicText)
                    }
                  }
                }
              }
              .onTapGesture {
                if changeData {
                  showPinPool.toggle()
                  if showPinPool {
                    updatedPin = ""
                  }
                }
              }
              Cell(title: "Notifacations") {
                Toggle("", isOn: $showNotifications)
                  .padding(.trailing, 15)
                  .tint(Colors.toggleColor)
              }
              NavigationLink(destination: AddMemberView()) {
                AddMemberCell()
              }
            }
          }
          .background(Colors.listBackground)
          .frame(width: UIScreen.main.bounds.width - 40)
          .cornerRadius(15)
          Spacer()
          Spacer()
          
          Button(action: {checkForUpdateUser() ; viewModel.updateUser(updatedName: updatedName, updatedEmail: updatedEmail, updatedCurrency: updatedCurrency, updatedLimit: Int16(updatedLimit), updatedPincode: updatedPin); changeData = false }) {
            Text("Update")
              .font(.system(size: 15, weight: .bold))
              .foregroundColor(.white)
              .frame(height: 60)
              .frame(maxWidth: .infinity)
              .background(Colors.purpleButton)
              .cornerRadius(30)
              .padding(.horizontal, 20)
              .opacity(changeData ? 1 : 0)
          }
          .padding(.bottom, 50)
        }
      }
    }
    .fullScreenCover(isPresented: $showPinPool) {
        PinCodeButtonsGrid(pin: $updatedPin)
    }
    .toolbar {
      HStack{
      Button(action: { changeData.toggle()
      }) {
        Image(systemName: "slider.horizontal.3")
      }
        Button(action: { showAlert = true
        }) {
          Image(systemName: "trash.circle")
        }
        .alert("You wanna delete all user data ?", isPresented: $showAlert) {
          Button("OK", role: .cancel) { viewModel.deleteUser()}
          Button("NO", role: .destructive) {}
        }
      }
    }
    .navigationTitle("")
  }
}

extension ProfileView {
  func checkForUpdateUser() {
    for user in viewModel.savedEntities {
      if updatedName.isEmpty {
        updatedName = user.name ?? ""
      }
      if updatedEmail.isEmpty {
        updatedEmail = user.email ?? ""
      }
    }
  }
}

struct Cell<Content> : View where Content : View {
  let title: String
  let content: () -> Content
  var cellHorizontalPadding: CGFloat = UIScreen.main.bounds.width - 70
  var cellHeight: CGFloat = 60
  
  init(title: String, @ViewBuilder content: @escaping () -> Content) {
    self.title = title
    self.content = content
  }
  var body: some View {
    HStack {
      Text(title)
        .modifier(UserProfileTitleModifier())
      Spacer()
      content()
    }
    .frame(height: cellHeight)
    .foregroundColor(.white)
    Divider()
      .frame(width: cellHorizontalPadding)
  }
}

struct AddMemberCell: View {
  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 7) {
        Image(systemName: "person.badge.plus")
          .resizable()
          .frame(width: 26, height: 22)
          .foregroundColor(Colors.addMember)
          .padding(.leading, 15)
        Text("Add a family member")
          .font(.system(size: 15, weight: .semibold))
          .foregroundColor(Colors.addMember)
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

