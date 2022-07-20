//
//  HomeView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 26.05.2022.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var operationViewModel = OperationViewModel()
  @ObservedObject var userViewModel = UserViewModel()
  @State private var progress = 0.0
  @State private var angle: Double = -90
  private var mainCircleWidth: CGFloat = UIScreen.main.bounds.width - 80
  @EnvironmentObject var tabData: TabViewModel

  var body: some View {
    ZStack {
      Colors.background
        .ignoresSafeArea()
        VStack {
          circularProgressView
            .onAppear {
              withAnimation {}
            }
          Text("Last actions")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(Colors.basicText)
          Spacer()
            List {
              ForEach(operationViewModel.savedOperations.prefix(3), id: \.self) { operation in
                ActionsRow(name: operation.category ?? "", image: operation.category?.lowercased() ?? "", description: operation.note ?? "", price: operation.sum , currency: operation.currency ?? "", date: operation.date ?? Date())
              }
              .onDelete(perform: operationViewModel.deleteOperation(indexSet:))
              if operationViewModel.savedOperations.count > 3 {
                Group {
                  NavigationLink(destination: ActionsView()) {
                    Text("See more")
                      .frame(height: 60)
                      .frame(maxWidth: .infinity)
                      .background(Colors.purpleButton)
                      .cornerRadius(30)
                      .padding(.vertical, 20)
                      .padding(.horizontal, 20)
                      .foregroundColor(.white)
                      .padding(.bottom, 30)
                  }
                  .padding(.trailing, -30)
                }
                .listRowBackground(Colors.listBackground)
              } else {
                EmptyView()
              }
            }
            .listStyle(.insetGrouped)
            .padding(.top, -30)
            .padding(.bottom, 50)
            .cornerRadius(30)
        }
    }
    .onAppear {
      operationViewModel.retrieveOperation()
    }
  }
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter
  }
}

struct ActionsRow: View {
  let name : String
  let image: String
  let description: String
  let price: Int16
  var currency: String
  let date: Date
  
  init (name: String, image: String, description: String, price: Int16, currency: String, date: Date) {
    self.name = name
    self.image = image
    self.description = description
    self.price = price
    self.currency = currency
    self.date = date
  }
  
  var body: some View {
    HStack{
      RoundedRectangle(cornerRadius: 10)
        .frame(width: 54, height: 54)
        .padding(.vertical, 12)
        .foregroundColor(Colors.imageBackground)
        .overlay(Image(image)
                  .resizable()
                  .scaledToFit()
                  .frame(width: 24, height: 24)
                  .padding(.horizontal, 12)
                  .padding(.vertical, 12))
      VStack(alignment: .leading, spacing: 3) {
        Text(name)
          .font(.system(size: 15, weight: .semibold))
        Text(description)
          .font(.system(size: 15, weight: .regular))
          .foregroundColor(.gray)
        Text(dateFormatter.string(from: date))
          .font(.system(size: 10, weight: .semibold))
          .foregroundColor(Colors.grayText)
      }
      Spacer()
      Text("\(currency.first?.description ?? "") \(price)")
        .font(.system(size: 15, weight: .semibold))
        .foregroundColor(Colors.circleText)
    }
    .listRowBackground(Colors.listBackground)
  }
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter
  }
}

extension HomeView {
  private var circularProgressView: some View {
    ZStack {
      Circle()
        .frame(width: mainCircleWidth)
        .foregroundColor(Colors.mailCircleBackground)
        .overlay {
          Circle()
            .frame(width: mainCircleWidth - 80)
            .foregroundColor(Colors.middleCircleBackground)
            .shadow(color: Colors.purpleButton, radius: 10, x: 0, y: 0)
            .overlay {
              ZStack {
                ProgressView(value: progress + getProgressAmount() , total: 1)
                  .progressViewStyle(GaugeProgressStyle())
                  .frame(width: mainCircleWidth - 95)
                  .overlay {
                    Circle()
                      .frame(width: 10, height: 10)
                      .foregroundColor(.white)
                      .offset(y: -(mainCircleWidth - 95) / 2 )
                    Circle()
                      .frame(width: 10, height: 10)
                      .foregroundColor(.white)
                      .offset(y: -(mainCircleWidth - 95) / 2 )
                      .rotationEffect(.degrees(Double(self.getProgressAmount()) * 360))
                  }
                VStack {
                    Text("\(operationViewModel.totalSumOfOperations())")
                    .font(.system(size: AdaptiveFonts.totalSumFont, weight: .semibold))
                      .minimumScaleFactor(0.7)
                      .foregroundColor(Colors.basicText)
                  Text("spent today")
                    .font(.system(size: AdaptiveFonts.spentTodayFont, weight: .regular))
                    .foregroundColor(Colors.grayText)
                  Divider()
                    .frame(width: mainCircleWidth - 125)
                  Text("balance for today")
                    .font(.system(size: AdaptiveFonts.balanceTodayFont, weight: .regular))
                    .foregroundColor(Colors.grayText)
                  ForEach(userViewModel.savedEntities, id: \.self) { user in
                    Text("\(user.limit)")
                      .font(.system(size: AdaptiveFonts.userLimitFont, weight: .semibold))
                      .foregroundColor(Colors.circleText)
                  }
                }
              }
            }
        }
    }
    .frame(width: mainCircleWidth, height: mainCircleWidth)
  }
  
  func getProgressAmount () -> Double {
    Double(operationViewModel.totalSumOfOperations()) / 1000
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}


