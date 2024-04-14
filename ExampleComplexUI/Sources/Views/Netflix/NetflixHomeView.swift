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
  @State private var products = [Product]()
  @State private var currentUser: User?
  
  var body: some View {
    ZStack(alignment: .top) {
      Color.netflixBlack.ignoresSafeArea()
      
      ScrollView {
        
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
          
          ForEach(0..<20) { item in
            Rectangle()
              .fill(.blue)
              .frame(height: 200)
          }
        }
      }
      .scrollIndicators(.hidden)
      
      mainView
        .getFrame($frame)
    }
    .task { await getData() }
  }
  
  private var mainView: some View {
    VStack(spacing: .zero) {
      headerView
      filterView
    }
    .foregroundStyle(.netflixWhite)
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
  
  private var filterView: some View {
    NetflixFilterBarView(FilterItem.preview, selectedFilter: selectedFilter)
      .action { item in
        selectedFilter = item
      }
      .clear {
        selectedFilter = .none
      }
      .padding(.top, 16)
  }
}

// MARK: - Get Data

extension NetflixHomeView {
  
  private func getData() async {
    guard products.isEmpty else { return }
    do {
      currentUser = try await DatabaseHelper().getUsers().first
      products = try await DatabaseHelper().getProducts()
      product = products.first
      
    } catch {}
  }
}


// MARK: - Preview

struct NetflixHomeView_Previews: PreviewProvider {
  
  static var previews: some View {
    NetflixHomeView()
  }
}
