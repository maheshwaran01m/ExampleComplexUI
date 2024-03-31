//
//  SpotifyHomeView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 31/03/24.
//

import SwiftUI

struct SpotifyHomeView: View {
  
  @State private var currentUser: User?
  @State private var selectedCategory: SpotifyCategory?
  @State private var products = [Product]()
  
  var body: some View {
    ZStack {
      Color.spotifyBlack.ignoresSafeArea()
      
      mainView
    }
    .task {
      await getData()
    }
  }
  
  // MARK: - Main View
  
  private var mainView: some View {
    ScrollView {
      LazyVStack(pinnedViews: [.sectionHeaders]) {
        Section {
         gridView
        } header: { headerView }
      }
    }
    .scrollIndicators(.hidden)
    .clipped()
    .toolbar(.hidden, for: .navigationBar)
  }
  
  private var gridView: some View {
    VStack {
      NonLazyVGrid(columns: 2, items: products) { product in
        if let product {
          SpotifyRecentCell(product.title, imageURL: product.firstImage)
        }
      }
    }
    .padding(.horizontal, 16)
  }
  
  // MARK: - Header
  
  private var headerView: some View {
    HStack(spacing: .zero) {
      ZStack {
        if let currentUser {
          ImageLoaderView(currentUser.image)
            .background(Color.spotifyWhite)
            .clipShape(Circle())
            .onTapGesture {
              
            }
        }
      }
      .frame(width: 35, height: 35)
      
      ScrollView(.horizontal) {
        HStack(spacing: 8) {
          ForEach(SpotifyCategory.allCases, id: \.rawValue) { category in
            SpotifyCategoryCell(category.rawValue.capitalized,
                                isSelected: selectedCategory == category)
            .onTapGesture {
              selectedCategory = category
            }
          }
        }
        .padding(.horizontal, 16)
      }
      .scrollIndicators(.hidden)
    }
    .padding(.vertical, 24)
    .padding(.leading, 8)
    .background(Color.spotifyBlack)
  }
  
  // MARK: - Get Data
  
  private func getData() async {
    do {
      currentUser = try await DatabaseHelper().getUsers().first
      products = try await Array(DatabaseHelper().getProducts().prefix(8))
    } catch {}
  }
}

// MARK: - Preview

struct SpotifyHomeView_Previews: PreviewProvider {
  
  static var previews: some View {
    SpotifyHomeView()
  }
}

// MARK: - NonLazyVGrid

public struct NonLazyVGrid<T, Content:View>: View {
  
  private let columns: Int
  private let alignment: HorizontalAlignment
  private let spacing: CGFloat
  private let items: [T]
  
  @ViewBuilder var content: (T?) -> Content
  
  public init(columns: Int = 2,
              alignment: HorizontalAlignment = .center,
              spacing: CGFloat = 10, items: [T],
              @ViewBuilder content: @escaping (T?) -> Content) {
    
    self.columns = columns
    self.alignment = alignment
    self.spacing = spacing
    self.items = items
    self.content = content
  }
  
  private var rowCount: Int {
    Int((Double(items.count) / Double(columns)).rounded(.up))
  }
  
  public var body: some View {
    VStack(alignment: alignment, spacing: spacing, content: {
      
      ForEach(Array(0..<rowCount), id: \.self) { rowIndex in
        
        HStack(alignment: .top, spacing: spacing, content: {
          
          ForEach(Array(0..<columns), id: \.self) { columnIndex in
            
            let index = (rowIndex * columns) + columnIndex
            if index < items.count {
              content(items[index])
            } else {
              content(nil)
            }
          }
        })
      }
    })
  }
}
