//
//  OnboardingView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 24.05.2022.
//

import SwiftUI

struct OnboardingView: View {
  @StateObject var viewModel = UserViewModel()
  @State var onboardingState: Int = 0
  @State private var progressAmount = 0.0
  @State var isValidate : Bool = false
  @Binding var currentUserSignedIn : Bool
  @State var isAccountCreated: Bool = false

  var body: some View {
    ZStack {
      Colors.background
        .ignoresSafeArea()
      VStack(spacing: 0) {
        progress
        ZStack {
          switch onboardingState {
          case 0:
            firstOnboardSection
          case 1:
            secondOnboardSection
          case 2:
            thirdOnboardSection
          case 3:
            AccountView(isValidate: $isValidate, isAccountCreated: $isAccountCreated, onboardingState: $onboardingState)
          case 4:
            RegistrationDoneView()
              .onAppear {
                print("register done")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
                  currentUserSignedIn = true
                }
              }
          default:
            EmptyView()
          }
        }
        Spacer()
        if onboardingState < 3 {
          purpleButton
          grayButton
        }
      }
    }
    .onAppear {
      withAnimation {
        progressAmount = 33.3
      }
    }
  }
}

extension OnboardingView {
  private var purpleButton: some View {
    Text(onboardingState == 2 ? "Get Started" : "Next")
      .font(.system(size: 15, weight: .bold))
      .foregroundColor(.white)
      .frame(height: 60)
      .frame(maxWidth: .infinity)
      .background(Colors.purpleButton)
      .cornerRadius(30)
      .padding(.horizontal, 20)
      .animation(nil)
      .opacity(onboardingState == 4 ? 0 : 1)
      .onTapGesture {
        handleNextButtonPressed()
      }
  }
  
  private var grayButton: some View {
    Text("Skip")
      .font(.system(size: 15, weight: .regular))
      .foregroundColor(onboardingState == 3 ? .clear : Colors.skipButton)
      .opacity(onboardingState == 4 ? 0 : 1)
      .padding()
  }
  
  private var progress: some View {
    HStack {
      Button(action: {handlePrevButtonPressed()}) {
        Image(systemName: "chevron.left")
          .frame(width: 27, height: 27)
          .foregroundColor(onboardingState == 0 ? .clear : onboardingState == 4 ? .clear : Colors.purpleButton)
          .padding(.leading, 12)
      }
      .disabled(onboardingState == 0)
      Spacer()
      ProgressView(value: progressAmount, total: 101)
        .progressViewStyle(MyProgressViewStyle())
        .padding(.leading, -35)
        .opacity(onboardingState == 3 ? 0 : onboardingState == 4 ? 0 : 1)
      Spacer()
    }
    .padding(.bottom, 20)
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
          onboardingState += 1
        }
      }
  }
  
  private var firstOnboardSection: some View {
    VStack(spacing: 10) {
      Text("Take hold of your finances")
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(Colors.basicText)
        .padding(.bottom, 11)
      Text("Managing your finances can be effortless")
        .font(.system(size: 15, weight: .regular))
        .foregroundColor(Colors.grayText)
        .padding(.bottom, 20)
      Image("1")
        .resizable()
        .scaledToFit()
    }
  }
  
  private var secondOnboardSection: some View {
    VStack(spacing: 0) {
      Text("See where your money goes")
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(Colors.basicText)
        .padding(.bottom, 11)
      Text("This app helps your to track your income and expenditure via automatic bank synchronization or manually")
        .font(.system(size: 15, weight: .regular))
        .foregroundColor(Colors.grayText)
        .multilineTextAlignment(.center)
        .padding(.bottom, 20)
      Image("2")
        .resizable()
        .scaledToFit()
    }
  }
  
  private var thirdOnboardSection: some View {
    VStack(spacing: 0) {
      Text("Reach your goals with ease")
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(Colors.basicText)
        .padding(.bottom, 11)
      Text("Managing your finances can be effortless Budget App makes it a breeze")
        .font(.system(size: 15, weight: .regular))
        .foregroundColor(Colors.grayText)
        .multilineTextAlignment(.center)
        .padding(.bottom, 20)
      Image("3")
        .resizable()
        .scaledToFit()
    }
  }
}

extension OnboardingView {
  func handleNextButtonPressed() {
    withAnimation(.spring()) {
      onboardingState += 1
      if onboardingState == 1 {
        progressAmount += 33.3
      } else if onboardingState == 2 {
        progressAmount += 33.3
      }
    }
  }
  
  func handlePrevButtonPressed() {
    withAnimation(.spring()) {
      onboardingState -= 1
      if onboardingState <= 1 {
        progressAmount -= 33.3
      } else if onboardingState == 3 {
        progressAmount = 99.9
      }
    }
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView( isValidate: false, currentUserSignedIn: .constant(false))
  }
}
