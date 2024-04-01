//
//  SpotifyPlaylistHeaderCell.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 31/03/24.
//

import SwiftUI

struct SpotifyPlaylistHeaderCell: View {
  
  let title: String
  let subtitle: String
  let imageName: String
  let shadowColor: Color
  let height: CGFloat
  
  init(_ title: String = "", subtitle: String = "",
       imageName: String = DatabaseHelper.imageURL,
       shadowColor: Color = Color.spotifyBlack.opacity(0.8),
       height: CGFloat = 300) {
    
    self.title = title
    self.subtitle = subtitle
    self.imageName = imageName
    self.shadowColor = shadowColor
    self.height = height
  }
  
  var body: some View {
    Rectangle()
      .opacity(0)
      .overlay { ImageLoaderView(imageName) }
      .overlay(alignment: .bottomLeading, content: overlayView)
      .stretchyHeader(height: height)
  }
  
  private func overlayView() -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(subtitle)
        .font(.headline)
      
      Text(title)
        .font(.largeTitle)
        .fontWeight(.bold)
    }
    .padding(16)
    .foregroundStyle(.spotifyWhite)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      LinearGradient(colors: [shadowColor.opacity(0), shadowColor],
                     startPoint: .top, endPoint: .bottom)
    )
  }
}

// MARK: - Preview

struct SpotifyPlaylistHeaderCell_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      ScrollView {
        SpotifyPlaylistHeaderCell("Some Playlist", subtitle: "Example")
      }
      .ignoresSafeArea(.container, edges: .top)
    }
  }
}
