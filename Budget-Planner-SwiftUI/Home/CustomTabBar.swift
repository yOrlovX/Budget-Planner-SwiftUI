//
//  CustomTabBar.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 31.05.2022.
//

import SwiftUI

struct CustomTabBar: View {
  @StateObject var tabData = TabViewModel()
  
  init() {
    UITabBar.appearance().isHidden = true
  }
  @Namespace var animation
  
  var body: some View {
    NavigationView {
      TabView(selection: $tabData.currentTab) {
        HomeView()
          .environmentObject(tabData)
          .tag("Home")
          .navigationBarTitleDisplayMode(.inline)
          .navigationTitle("")
        AddCardView()
          .environmentObject(tabData)
          .tag("Card")
        AddOperationView()
          .environmentObject(tabData)
          .tag("")
        BaseView()
          .environmentObject(tabData)
          .tag("Statistics")
        TipsView()
          .environmentObject(tabData)
          .tag("Tips")
      }
      .toolbar {
        NavigationLink(destination: ProfileView()) {
          Image(systemName: "person.fill")
            .frame(width: 27, height: 27)
            .foregroundColor(tabData.currentTab != "Home" ? .clear : Colors.purpleButton)
        }.disabled(tabData.currentTab != "Home")
      }
      .overlay(
        HStack{
          TabBarButton(title: "Home", image: "Home", animation: animation)
          TabBarButton(title: "Card", image: "Card", animation: animation)
          TabBarButton(title: "", image: "plusButton", animation: animation)
          TabBarButton(title: "Statistics", image: "Statistics", animation: animation)
          TabBarButton(title: "Tips", image: "Tips", animation: animation)
        }
          .environmentObject(tabData)
          .padding(.top, 5)
          .background(.thinMaterial)
        ,alignment: .bottom
      )
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .accentColor(Colors.purpleButton)
  }
}

struct CustomTabBar_Previews: PreviewProvider {
  static var previews: some View {
    CustomTabBar()
  }
}

struct TabBarButton: View {
  var title: String
  var image: String
  var animation: Namespace.ID
  @EnvironmentObject var tabData: TabViewModel
  
  var body: some View {
    Button {
      withAnimation {
        tabData.currentTab = title
      }
    }
  label: {
    VStack {
      Image(image)
        .renderingMode(image == "plusButton" ? nil : .template)
        .foregroundColor(tabData.currentTab == image ? .purple : .gray)
      
      Text(title)
        .font(.system(size: 10, weight: .bold))
    }
    .foregroundColor(tabData.currentTab == title ? .purple : .gray)
    .frame(maxWidth: .infinity)
  }
  }
}
