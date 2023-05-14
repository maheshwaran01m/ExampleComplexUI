//
//  SpotityPlaylistView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 31/03/24.
//

import SwiftUI

struct SpotityPlaylistView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  let product: Product
  let user: User
  
  @State private var products = [Product]()
  @State private var showHeader = false
  
  init(product: Product = .preview,
       user: User = .preview) {
    self.product = product
    self.user = user
  }
  
  var body: some View {
    ZStack {
      Color.spotifyBlack.ignoresSafeArea()
      
      ScrollView {
        mainView
      }
      .scrollIndicators(.hidden)
      
      headerView
    }
    .task { await getData() }
    .toolbar(.hidden, for: .navigationBar)
  }
  
  private var mainView: some View {
    LazyVStack {
      SpotifyPlaylistHeaderCell(
        product.title,
        subtitle: product.brand,
        imageName: product.thumbnail)
      .background(content: backgroundView)
      
      SpotifyPlaylistDecriptionCell(
        descriptionText: product.description,
        userName: user.firstName,
        subheadline: product.category)
      .padding(.horizontal, 16)
      
      detailView
    }
  }
  
  private var detailView: some View {
    ForEach(products) { product in
      SpotifySongRowCell(
        imageName: product.thumbnail,
        imageSize: 50,
        title: product.title,
        subtitle: product.description)
    }
    .padding(.leading, 16)
  }
    }
  }
  

// MARK: - Get Data

extension SpotityPlaylistView {
  
  private func getData() async {
    do {
      products = try await DatabaseHelper().getProducts()
    } catch {}
  }
}

// MARK: - Preview

struct SpotityPlaylistView_Previews: PreviewProvider {
  
  static var previews: some View {
    SpotityPlaylistView()
  }
}
