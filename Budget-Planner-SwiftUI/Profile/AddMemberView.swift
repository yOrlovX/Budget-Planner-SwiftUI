//
//  AddMemberView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 26.05.2022.
//

import SwiftUI

struct AddMemberView: View {
  var cellHeight: CGFloat = 60
  
    var body: some View {
      ZStack {
        Colors.background
          .ignoresSafeArea()
        VStack {
          Image("member")
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 115)
          Text("Add a family member")
            .font(.system(size: 20, weight: .bold))
            .padding(.bottom)
          Text("Add your family members and control your \nbudget together")
            .font(.system(size: 15, weight: .regular))
            .foregroundColor(Colors.grayText)
            .multilineTextAlignment(.center)
            .padding(.bottom)
          VStack(spacing: 0) {
            linkCell
            telegramCell
            facebookCell
            viberCell
          }
          .frame(width: UIScreen.main.bounds.width - 40)
          .background(.white)
          .cornerRadius(10)
          Spacer()
        }
      }
    }
}

extension AddMemberView {
  private var linkCell: some View {
    VStack(spacing: 0) {
      HStack(spacing:0) {
        Text("dfgtrhrt643hyth3th")
          .font(.system(size: 15, weight: .medium))
          .foregroundColor(.white)
          .frame(maxWidth: .infinity, alignment: .leading)
          .frame(maxHeight: cellHeight - 20)
          .padding(.leading, 14)
          .background(.gray)
          .opacity(0.7)
          .cornerRadius(10, corners: [.topLeft, .bottomLeft])
          .padding(.leading, 14)
        Button(action: {}) {
          Text("Copy link")
            .font(.system(size: 15, weight: .bold))
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: cellHeight - 20)
        .background(Colors.purpleButton)
        .cornerRadius(10, corners: [.topRight, .bottomRight])
        .padding(.trailing, 14)
      }
      .frame(height: cellHeight)
    }
  }
  
  private var telegramCell: some View {
    VStack(spacing: 0) {
      HStack {
        Image("telegram")
          .resizable()
          .scaledToFit()
          .frame(width: 36, height: 36)
          .padding(.leading, 14)
        
        Text("Telegram")
          .font(.system(size: 15, weight: .medium))
        Spacer()
      }
      .frame(height: cellHeight)
      Divider()
      .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
  
  private var facebookCell: some View {
    VStack(spacing: 0) {
      HStack {
        Image("facebook")
          .resizable()
          .scaledToFit()
          .frame(width: 36, height: 36)
          .padding(.leading, 14)
        
        Text("Facebook")
          .font(.system(size: 15, weight: .medium))
        Spacer()
      }
      .frame(height: cellHeight)
      Divider()
      .frame(width: UIScreen.main.bounds.width - 70)
    }
  }
  
  private var viberCell: some View {
    VStack(spacing: 0) {
      HStack {
        Image("viber")
          .resizable()
          .scaledToFit()
          .frame(width: 36, height: 36)
          .padding(.leading, 14)
        
        Text("Viber")
          .font(.system(size: 15, weight: .medium))
        Spacer()
      }
      .frame(height: cellHeight)
    }
  }
}

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView()
    }
}


