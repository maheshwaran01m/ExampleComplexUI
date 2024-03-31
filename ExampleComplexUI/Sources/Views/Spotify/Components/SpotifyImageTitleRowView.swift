//
//  SpotifyImageTitleRowView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 31/03/24.
//

import SwiftUI

struct SpotifyImageTitleRowView: View {
  
  private let imageSize: CGFloat
  private let imageName: String
  private let title: String
  
  init(_ imageName: String = DatabaseHelper.imageURL,
       imageSize: CGFloat = 100, title: String = "") {
    self.imageSize = imageSize
    self.imageName = imageName
    self.title = title
  }
  
  var body: some View {
    VStack(spacing: 8) {
      
      ImageLoaderView(imageName)
        .frame(width: imageSize, height: imageSize)
      
      Text(title)
        .font(.callout)
        .foregroundStyle(.spotifyLightGray)
        .lineLimit(2)
        .padding(4)
    }
    .frame(width: imageSize)
  }
}

// MARK: - Preview

struct SpotifyImageTitleRowView_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      SpotifyImageTitleRowView(title: "Title")
    }
  }
}
