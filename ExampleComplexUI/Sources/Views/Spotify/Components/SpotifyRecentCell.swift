//
//  SpotifyRecentCell.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 31/03/24.
//

import SwiftUI

struct SpotifyRecentCell: View {
  
  let imageURL: String
  let title: String
  
  init(_ title: String = "Title", imageURL: String = "https://picsum.photos/600/600") {
    self.title = title
    self.imageURL = imageURL
  }
  
  
  var body: some View {
    HStack(spacing: 16) {
      
      ImageLoaderView(imageURL)
        .frame(width: 55, height: 55)
      
      Text(title)
        .font(.callout)
        .fontWeight(.semibold)
        .lineLimit(2)
    }
    .padding(.trailing, 8)
    .frame(maxWidth: .infinity, alignment: .leading)
    .themeColor()
    .clipShape(RoundedRectangle(cornerRadius: 6))
  }
}

// MARK: - Preview

struct SpotifyRecentCell_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      VStack {
        HStack {
          SpotifyRecentCell()
          SpotifyRecentCell()
        }
        
        HStack {
          SpotifyRecentCell()
          SpotifyRecentCell()
        }
      }
    }
  }
}
