//
//  BaseView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 03.06.2022.
//

import SwiftUI

struct BaseView: View {
  @State var currentTab: String = "Spent"
  @Namespace var animation
  @State var showEarned: Bool = false
  @State private var calendarText: String = ""
  @State private var currentDateText: Date = Date()
  @State private var futureDateText: Date = Date()
  @State private var showDatePicker: Bool = false
  
    var body: some View {
      ZStack {
        Colors.background
          .ignoresSafeArea()
        ScrollView {
          VStack {
            Text("Statistics")
              .font(.system(size: 34, weight: .bold))
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 20)
            Text("Expenses calendar")
              .font(.system(size: 20, weight: .bold))
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 20)
              .padding(.top, 20)
            VStack {
              Text("\(currentDateText.formatted(date: .abbreviated, time: .omitted) + " - " + futureDateText.formatted(date: .abbreviated, time: .omitted))")
                .font(.system(size: 13, weight: .regular))
            }
            .padding(.leading, 18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 60)
            .background(.white)
            .cornerRadius(20)
            .overlay(alignment: .trailing) {
              Button(action: { showDatePicker.toggle() }) {
                Image(systemName: "calendar")
                  .padding(.trailing, 18)
                  .frame(width: 23, height: 23)
                  .foregroundColor(.gray)
              }
            }
            .padding(.horizontal, 20)
            VStack {
              CustomSegmentedBar()
                .padding(.top, 24)
              GraphView()
                .padding(.bottom, 24)
            }
            .background(.white)
            .cornerRadius(20)
            .padding(.horizontal, 20)
            SpendingBreakdownView()
              .padding(.top, 30)
          }
        }
        .padding(.bottom, 70)
      }
      .overlay {
        ZStack {
          if showDatePicker {
            Rectangle()
              .fill(.ultraThinMaterial)
              .ignoresSafeArea()
              .onTapGesture {
                showDatePicker = false
              }
            DatePicker.init("", selection: $futureDateText, in: Date.now...Date.distantFuture)
              .datePickerStyle(.graphical)
              .labelsHidden()
              .padding()
              .background(.white, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
              .padding()
          }
        }
      }
    }
  
  @ViewBuilder
  func CustomSegmentedBar() -> some View {
     let tabs = ["Spent", "Earned"]
    HStack(spacing: 10) {
      ForEach(tabs, id: \.self) { tab in
        Text(tab)
          .font(.system(size: 13, weight: .semibold))
          .foregroundColor(currentTab == tab ? .white : .black)
          .frame(height: 38)
          .frame(maxWidth: .infinity )
          .background {
            if currentTab == tab {
              Capsule()
                .fill(Colors.purpleButton)
                .matchedGeometryEffect(id: "TAB", in: animation)
            }
          }
          .contentShape(Capsule())
          .onTapGesture {
            currentTab = tab
            showEarned.toggle()
          }
      }
    }
    .padding(.horizontal, 18)
  }
  
  @ViewBuilder
  func GraphView () -> some View {
    GeometryReader { proxy in
      ZStack {
        VStack(spacing: 0) {
          ForEach(getGraphLines(), id: \.self) { line in
            HStack(spacing: 8) {
              Text("\(Int(line))")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.gray)
                .frame(height:20)
              Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 1, alignment: .bottom)
            }
          }
        }
        .frame(maxHeight: .infinity)
        HStack {
          ForEach(showEarned ? chartData : chartDat2) { data in
            VStack(spacing: 0) {
              VStack(spacing:5) {
                Capsule()
                  .fill(Colors.purpleButton)
              }
              .frame(width: 8)
              .frame(height: getBarHeight(point: data.progress, size: proxy.size))
              Text(data.day)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.gray)
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
          }
        }
        .padding(.leading, 50)
      }
      .padding(.horizontal, 20)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    .frame(height: 190)
  }
  
  func getBarHeight(point: CGFloat, size: CGSize) -> CGFloat {
    let max = getMax()
    let height = (point / max) * (size.height - 70)
    return height
  }
  
  func getGraphLines() -> [CGFloat] {
    let max = getMax()
    var lines : [CGFloat] = []
    lines.append(max)
    
    for index in 1..<7 {
      let progress = max / 7
      lines.append(max - (progress * CGFloat(index)))
    }
    return lines
  }
  
  func getMax() -> CGFloat {
    let max = chartData.max { first, second in
      return second.progress > first.progress
    }?.progress ?? 0
    return max
  }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}

struct ChartModel: Identifiable {
  var id = UUID()
  var progress: CGFloat
  var day: String
}

var chartData: [ChartModel] = [ChartModel(progress: 1000, day: "Mo"),
                               ChartModel(progress: 2000, day: "Tu"),
                               ChartModel(progress: 3000, day: "We"),
                               ChartModel(progress: 4000, day: "Th"),
                               ChartModel(progress: 5000, day: "Fr"),
                               ChartModel(progress: 6000, day: "Sa"),
                               ChartModel(progress: 7000, day: "Su")]

var chartDat2: [ChartModel] = [ChartModel(progress: 3000, day: "Mo"),
                               ChartModel(progress: 2000, day: "Tu"),
                               ChartModel(progress: 3000, day: "We"),
                               ChartModel(progress: 5000, day: "Th"),
                               ChartModel(progress: 5000, day: "Fr"),
                               ChartModel(progress: 6000, day: "Sa"),
                               ChartModel(progress: 1000, day: "Su")]
