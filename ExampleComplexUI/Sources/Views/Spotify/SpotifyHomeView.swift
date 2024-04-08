//
//  SpotifyHomeView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 31/03/24.
//

import SwiftUI

struct SpotifyHomeView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @State private var currentUser: User?
  @State private var selectedCategory: SpotifyCategory?
  @State private var products = [Product]()
  @State private var productCategory = [ProductCategory]()
  
  var body: some View {
    ZStack {
      Color.spotifyBlack.ignoresSafeArea()
      
      mainView
    }
    .overlay(alignment: .topLeading, content: closeButtonView)
    .task {
      await getData()
    }
  }
  
  // MARK: - Main View
  
  private var mainView: some View {
    ScrollView {
      LazyVStack(pinnedViews: [.sectionHeaders]) {
        
        Section {
          VStack(spacing: 16) {
            recentView
            newReleaseView
            productListView
          }
        } header: { headerView }
      }
    }
    .padding(.top, 10)
    .scrollIndicators(.hidden)
    .clipped()
    .toolbar(.hidden, for: .navigationBar)
    .navigationDestination(for: Product.self, destination: productDetailView)
  }
  
  private var recentView: some View {
    NonLazyVGrid(columns: 2, items: products) { product in
      if let product {
        NavigationLink(value: product) {
          SpotifyRecentCell(product.title, imageURL: product.firstImage)
        }
      }
    }
    .padding(.horizontal, 16)
  }
  
  @ViewBuilder
  private func productDetailView(_ product: Product) -> some View {
    if let currentUser {
      SpotityPlaylistView(product: product, user: currentUser)
    }
  }
  
  @ViewBuilder
  private var newReleaseView: some View {
    if let product = products.first {
      SpotifyNewReleaseCell(
        product.firstImage,
        headline: product.brand,
        subheadline: product.category,
        title: product.title,
        subTitle: product.description
      )
      .padding(.horizontal, 16)
    }
  }
  
  private var productListView: some View {
    VStack(spacing: 8) {
      
      ForEach(productCategory, id: \.id) { cateogry in
        
        Text(cateogry.title)
          .font(.title)
          .fontWeight(.semibold)
          .foregroundStyle(.spotifyWhite)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, 16)
        
        ScrollView(.horizontal) {
          HStack(alignment: .top, spacing: 16) {
            ForEach(cateogry.products, id: \.id) { product in
              SpotifyImageTitleRowView(product.firstImage,
                                       title: product.title)
            }
          }
          .padding(.horizontal, 16)
        }
      }
    }
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
              dismiss()
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
  
  private func closeButtonView() -> some View {
    Image(systemName: "chevron.left")
      .font(.title3)
      .padding(8)
      .onTapGesture {
        dismiss()
      }
      .foregroundStyle(.spotifyWhite)
  }
  
  // MARK: - Get Data
  
  private func getData() async {
    guard products.isEmpty else { return }
    do {
      currentUser = try await DatabaseHelper().getUsers().first
      products = try await Array(DatabaseHelper().getProducts().prefix(8))
      
      productCategory = Set(products.map { $0.brand }).map { brand in
        
        let products = self.products.filter { $0.brand == brand }
        
        return ProductCategory(title: brand, products: products)
      }
    } catch {}
  }
}

// MARK: - Preview

struct SpotifyHomeView_Previews: PreviewProvider {
  
  static var previews: some View {
    NavigationStack {
      SpotifyHomeView()
    }
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
