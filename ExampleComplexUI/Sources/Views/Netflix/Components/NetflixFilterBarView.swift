//
//  NetflixFilterBarView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 13/04/24.
//

import SwiftUI

struct NetflixFilterBarView: View {
  
  private let filters: [FilterItem]
  private var onCloseClicked: (() -> Void)?
  
  private var selectedFilter: FilterItem?
  private var onFilterClicked: ((FilterItem) -> Void)?
  
  init(_ filters: [FilterItem] = FilterItem.preview,
       selectedFilter: FilterItem? = nil) {
    self.filters = filters
    self.selectedFilter = selectedFilter
  }
  
  var body: some View {
    ScrollView(.horizontal) {
      mainView
    }
    .scrollIndicators(.hidden)
    .animation(.bouncy, value: selectedFilter)
  }
  
  private var mainView: some View {
    HStack {
      
      if selectedFilter != nil {
        Image(systemName: "xmark")
          .padding(8)
          .background(Circle().stroke(lineWidth: 1))
          .foregroundStyle(.netflixLightGray)
          .background(Color.black.opacity(0.001))
          .onTapGesture { onCloseClicked?() }
          .transition(.move(edge: .leading))
          .padding(.leading, 16)
      }
      
      filterView
    }
    .padding(.vertical, 4)
    .background(Color.black.opacity(0.001))
  }
  
  private var filterView: some View {
    ForEach(filters, id: \.self) { item in
      if selectedFilter == nil || selectedFilter == item {
        
        NetflixFilterView(
          title: item.title,
          isDropdown: item.isDropdown,
          isSelected: selectedFilter == item)
        .background(Color.black.opacity(0.001))
        .onTapGesture {
          onFilterClicked?(item)
        }
        .padding(.leading, (selectedFilter == nil && filters.first == item) ? 16 : 0)
      }
    }
  }
}

extension NetflixFilterBarView {
  
  func action(_ action: @escaping (FilterItem) -> Void) -> Self {
    var newView = self
    newView.onFilterClicked = action
    return newView
  }
  
  func clear(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onCloseClicked = action
    return newView
  }
}

struct FilterItem: Hashable {
  let title: String
  let isDropdown: Bool
  
  static var preview: [Self] {
    [.init(title: "Tv shows", isDropdown: false),
     .init(title: "Movie", isDropdown: false),
      .init(title: "Categories", isDropdown: true)]
  }
}

// MARK: - Preview

struct NetflixFilterBarView_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.netflixBlack.ignoresSafeArea()
      
      PreviewView()
    }
  }
  
  struct PreviewView: View {
    
    @State private var selectedFilter: FilterItem?
    
    var body: some View {
      NetflixFilterBarView(FilterItem.preview, selectedFilter: selectedFilter)
        .action { item in
          selectedFilter = item
        }
        .clear {
          selectedFilter = .none
        }
    }
  }
}
