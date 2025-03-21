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
  
  private var headerView: some View {
    ZStack {
      Text(product.title)
        .font(.headline)
        .foregroundStyle(.spotifyWhite)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(Color.spotifyBlack)
//        .offset(y: showHeader ? 0 : -40)
//        .transition(.move(edge: .bottom).combined(with: .slide))
        .opacity(showHeader ? 1 : 0)
      
      Image(systemName: "chevron.left")
        .font(.title3)
        .padding(10)
        .background(showHeader ? Color.black.opacity(0.001) :
                      Color.spotifyGray.opacity(0.7))
        .clipShape(Circle())
        .onTapGesture {
          dismiss()
        }
        .padding(.leading, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .foregroundStyle(.spotifyWhite)
    .animation(.smooth(duration: 0.2), value: showHeader)
    .frame(maxHeight: .infinity, alignment: .top)
  }
  
  private func backgroundView() -> some View {
    GeometryReader { proxy in
      Color.clear
        .onAppear {
          showHeader = proxy.frame(in: .global).maxY < 150
        }
        .onChange(of: proxy.frame(in: .global).maxY) {
          showHeader = $0 < 150
        }
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
