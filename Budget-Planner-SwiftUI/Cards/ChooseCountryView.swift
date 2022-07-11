//
//  ChooseCountryView.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 30.05.2022.
//

import SwiftUI

struct ChooseCountryView: View {
  @State var selectedRow: CountryModel?
  @State var searchText: String = ""
  @State var searching = false
  var countriesList: [CountryModel] = CountryCell.countries
  
  var body: some View {
    ZStack {
      Colors.background
        .ignoresSafeArea()
      VStack {
        Spacer()
        registrationProgress
        Spacer()
        Text("Choose country")
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 20)
          .padding(.top, 20)
          .font(.system(size: 20, weight: .bold))
        SearchBar(searchText: $searchText, searching: $searching)
        List {
          ForEach(countriesList, id: \.self) { country in
            CountryRow(rowData: country, selectedRow: self.$selectedRow)
          }
        }
        .listStyle(.insetGrouped)
        NavigationLink(destination: ChooseBankView()) {
          Text("Next")
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(Colors.purpleButton)
            .cornerRadius(30)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
            .padding(.top, 20)
        }
      }
    }
    .navigationTitle("")
  }
}

private var registrationProgress: some View {
  HStack(spacing: 50) {
    VStack(spacing: 8) {
      Circle()
        .frame(width: 29, height: 29)
        .foregroundColor(Colors.purpleButton)
        .overlay {
          Text("1")
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
        .foregroundColor(.white)
        .overlay {
          Text("2")
            .font(.system(size: 15, weight: .semibold))
            .foregroundColor(Colors.purpleButton)
        }
      Text("Bank")
        .font(.system(size: 12, weight: .semibold))
        .foregroundColor(Colors.grayText)
    }
    VStack(spacing: 8) {
      Circle()
        .frame(width: 29, height: 29)
        .foregroundColor(.white)
        .overlay {
          Text("3")
            .font(.system(size: 15, weight: .semibold))
            .foregroundColor(Colors.purpleButton)
        }
      Text("Country")
        .font(.system(size: 12, weight: .semibold))
        .foregroundColor(Colors.grayText)
    }
  }
  .frame(maxWidth: .infinity)
}

struct CountryRow: View {
  let rowData: CountryModel
  @Binding var selectedRow: CountryModel?
  var body: some View {
    HStack {
      Image(rowData.image)
        .padding(.leading, 15)
      Text(rowData.name)
        .padding(.vertical, 22)
        .font(.system(size: 15, weight: .medium))
      Spacer()
      if rowData == selectedRow {
        Image(systemName: "checkmark")
          .foregroundColor(Colors.purpleButton)
          .padding(.trailing, 15)
      }
    }
    .background(.white)
    .onTapGesture {
      self.selectedRow = rowData
    }
  }
}

extension ChooseCountryView {
  private var searchBar: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .padding(.leading, 14)
      TextField("Search", text: $searchText)
        .foregroundColor(Colors.grayText)
      Spacer()
    }
    .frame(height: 44)
    .frame(maxWidth: .infinity)
    .background(.white)
    .cornerRadius(20)
    .padding(.horizontal, 20)
  }
}

struct SearchBar : View {
  @Binding var searchText: String
  @Binding var searching: Bool
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .padding(.leading, 14)
      TextField("Search", text: $searchText) { startedEditing in
           if startedEditing {
               withAnimation {
                   searching = true
               }
           }
       } onCommit: {
           withAnimation {
               searching = false
           }
       }
        .foregroundColor(Colors.grayText)
      Spacer()
    }
    .frame(height: 44)
    .frame(maxWidth: .infinity)
    .background(.white)
    .cornerRadius(20)
    .padding(.horizontal, 20)
  }
}


struct CountryModel: Identifiable, Equatable, Hashable {
  let id = UUID()
  let name: String
  let image: String
}

struct CountryCell {
  static var countries: [CountryModel] = [CountryModel(name: "Belgium", image: "belgium"),CountryModel(name: "Austria", image: "austria"),CountryModel(name: "Cambodia", image: "cambodia"),CountryModel(name: "Bulgaria", image: "bulgaria"),CountryModel(name: "Ukraine", image: "ukraine"),CountryModel(name: "Argentina", image: "argentina"),CountryModel(name: "Canada", image: "canada"),CountryModel(name: "Bahamas", image: "bahamas")]
}

struct ChooseCountryView_Previews: PreviewProvider {
  static var previews: some View {
    ChooseCountryView()
  }
}

