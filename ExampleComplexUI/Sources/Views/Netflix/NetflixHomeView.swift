//
//  NetflixHomeView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 13/04/24.
//

import SwiftUI

struct NetflixHomeView: View {
  
  @State private var selectedFilter: FilterItem?
  @State private var frame = CGRect.zero
  
  @State private var product: Product?
  @State private var products = [ProductCategory]()
  @State private var currentUser: User?
  
  @State private var scrollOffset = CGFloat.zero
  
  var body: some View {
    ZStack(alignment: .top) {
      Color.netflixBlack.ignoresSafeArea()
      gradientView
      scrollView
      mainView
    }
    .toolbar(.hidden, for: .navigationBar)
    .task { await getData() }
  }
  
  private var gradientView: some View {
    ZStack {
      LinearGradient(colors: [.netflixDarkGray, .netflixDarkRed.opacity(0)],
                     startPoint: .top, endPoint: .bottom)
      .ignoresSafeArea()
      
      LinearGradient(colors: [.netflixDarkRed.opacity(0.5), .netflixDarkRed.opacity(0)],
                     startPoint: .top, endPoint: .bottom)
      .ignoresSafeArea()
    }
    .frame(maxHeight: max(10, 400 + (scrollOffset * 0.75)))
    .opacity(scrollOffset < -250 ? 0 : 1)
    .animation(.easeInOut, value: scrollOffset)
  }
  
  private var scrollView: some View {
    ScrollViewWithOnScroll(.vertical, showsIndicators: false) {
      
      VStack(spacing: 8) {
        Rectangle()
          .opacity(0)
          .frame(height: frame.height)
        
        if let product {
          NetflixMainView(
            imageName: product.firstImage,
            title: product.title,
            categories: [product.category.capitalized, product.brand])
          .padding(24)
        }
        
        detailView
      }
    } onScrollChanged: { offset in
      scrollOffset = min(0, offset.y)
    }
  }
  
  private var mainView: some View {
    VStack(spacing: .zero) {
      headerView
      filterView
    }
    .padding(.bottom, 8)
    .background {
      ZStack {
        if scrollOffset < -70 {
          Rectangle()
            .fill(.clear)
            .background(.ultraThinMaterial)
            .brightness(-0.2)
            .ignoresSafeArea()
        }
      }
    }
    .foregroundStyle(.netflixWhite)
    .animation(.smooth, value: scrollOffset)
    .getFrame { value in
      if frame == .zero {
        frame = value
      }
    }
  }
  
  private var headerView: some View {
    HStack(spacing: .zero) {
      Text("For You")
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.title)
      
      HStack(spacing: 16) {
        Image(systemName: "tv.badge.wifi")
          .onTapGesture {
            
          }
        Image(systemName: "magnifyingglass")
          .onTapGesture {
            
          }
      }
    }
    .padding(.horizontal, 16)
  }
  
  @ViewBuilder
  private var filterView: some View {
    if scrollOffset > -20 {
      NetflixFilterBarView(FilterItem.preview, selectedFilter: selectedFilter)
        .action { item in
          selectedFilter = item
        }
        .clear {
          selectedFilter = .none
        }
        .padding(.top, 16)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
  }
  
  private var detailView: some View {
    LazyVStack(spacing: 16) {
      
      ForEach(Array(products.enumerated()), id: \.offset) { (rowIndex, item) in
        
        VStack(alignment: .leading, spacing: 6) {
          Text(item.title)
            .font(.headline)
            .padding(.horizontal, 16)
          
          ScrollView(.horizontal) {
            LazyHStack {
              ForEach(Array(item.products.enumerated()), id: \.offset) { (index, product) in
                NetflixMovieView(
                  imageName: product.firstImage,
                  title: product.title,
                  isRecentlyAdded: Product.recentlyAdd,
                  toTenRanking: rowIndex == 1 ? index + 1 : nil)
              }
            }
            .padding(.horizontal, 16)
          }
        }
      }
    }
  }
}

// MARK: - Get Data

extension NetflixHomeView {
  
  private func getData() async {
    guard products.isEmpty else { return }
    do {
      currentUser = try await DatabaseHelper().getUsers().first
      
      let products = try await DatabaseHelper().getProducts()
      product = products.first
      
      self.products = Set(products.map { $0.brand }).map { brand in
        ProductCategory(title: brand, products: products.shuffled())
      }
      
    } catch {
      print("Error \(error.localizedDescription)")
    }
  }
}


// MARK: - Preview

struct NetflixHomeView_Previews: PreviewProvider {
  
  static var previews: some View {
    NetflixHomeView()
  }
}
