//
//  SpotityPlaylistView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 31/03/24.
//

import SwiftUI

struct SpotityPlaylistView: View {
  
  let product: Product
  let user: User
  
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
    }
  }
  
  private var mainView: some View {
    LazyVStack {
      SpotifyPlaylistHeaderCell(
        product.title,
        subtitle: product.brand,
        imageName: product.thumbnail)
      
      SpotifyPlaylistDecriptionCell(
        descriptionText: product.description,
        userName: user.firstName,
        subheadline: product.category)
      .padding(.horizontal, 16)
    }
  }

}

// MARK: - Preview

struct SpotityPlaylistView_Previews: PreviewProvider {
  
  static var previews: some View {
    SpotityPlaylistView()
  }
}
