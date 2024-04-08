//
//  ContentView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 28/03/24.
//

import SwiftUI

struct ContentView: View {
  
  @State private var records = ViewCoordinator.allCases
  
  @State private var searchText = ""
  
  private var filterViews: [ViewCoordinator] {
    guard !searchText.isEmpty else { return records }
    return records.filter { $0.title.lowercased().localizedCaseInsensitiveContains(searchText) }
  }
    
  var body: some View {
    NavigationStack {
      mainView
        .navigationTitle("Example")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
  }
  
  @ViewBuilder
  private var mainView: some View {
    if !filterViews.isEmpty {
      listView
    } else {
      placeholderView
    }
  }
  
  private var listView: some View {
    List(filterViews, id: \.rawValue) { record in
      NavigationLink(record.title, destination: record.destinationView)
    }
    .listStyle(.plain)
  }
}

// MARK: - Placeholder View

extension ContentView {
  
  private var placeholderView: some View {
    ZStack {
      Color.secondary.opacity(0.1)
      
      VStack(spacing: 16) {
        iconView
        titleView
      }
    }
    .ignoresSafeArea(.container, edges: .bottom)
  }
  
  private var titleView: some View {
    Text("No Examples Available")
      .font(.title3)
      .frame(minHeight: 22)
      .multilineTextAlignment(.center)
      .foregroundStyle(.secondary)
  }
  
  private var iconView: some View {
    Image(systemName: "square.on.square.badge.person.crop")
      .font(.title)
      .foregroundStyle(Color.secondary)
      .frame(minWidth: 20, minHeight: 20)
  }
}

// MARK: - ViewCoordinator

extension ContentView {
  
  enum ViewCoordinator: String, CaseIterable {
    case spotify, bumble
    
    var title: String {
      self.rawValue.capitalized
    }
    
    @ViewBuilder
    var destinationView: some View {
      switch self {
      case .spotify: SpotifyHomeView()
      case .bumble: BumbleHomeView()
      }
    }
  }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    NavigationStack {
      ContentView()
    }
  }
}
