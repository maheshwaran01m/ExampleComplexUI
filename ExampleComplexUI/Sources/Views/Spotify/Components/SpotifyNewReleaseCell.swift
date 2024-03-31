//
//  SpotifyNewReleaseCell.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 31/03/24.
//

import SwiftUI

struct SpotifyNewReleaseCell: View {
  
  let imageName: String
  let headline: String?
  let subheadline: String?
  let title: String?
  let subTitle: String?
  
  var onAddTapAction: (() -> Void)?
  var onPlayTapAction: (() -> Void)?
  
  init(_ imageName: String = DatabaseHelper.imageURL,
       headline: String? = nil,
       subheadline: String? = nil,
       title: String? = nil,
       subTitle: String? = nil) {
    
    self.imageName = imageName
    self.headline = headline
    self.subheadline = subheadline
    self.title = title
    self.subTitle = subTitle
  }
  
  var body: some View {
    VStack(spacing: 16) {
      headerView
      mainView
    }
  }
  
  private var headerView: some View {
    HStack(spacing: 8) {
      ImageLoaderView(imageName)
        .frame(width: 50, height: 50)
        .clipShape(Circle())
      
      VStack(alignment: .leading, spacing: 2) {
        if let headline {
          Text(headline)
            .foregroundStyle(.spotifyLightGray)
            .font(.callout)
        }
        
        if let subheadline {
          Text(subheadline)
            .foregroundStyle(.spotifyWhite)
            .font(.title2)
            .fontWeight(.medium)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var mainView: some View {
    HStack {
      ImageLoaderView(imageName)
        .frame(width: 140, height: 140)
      
      VStack(alignment: .leading, spacing: 32) {
        VStack(alignment: .leading, spacing: 2) {
          if let title {
            Text(title)
              .fontWeight(.semibold)
              .foregroundStyle(.spotifyWhite)
          }
          
          if let subTitle {
            Text(subTitle)
              .foregroundStyle(.spotifyLightGray)
              .fontWeight(.medium)
          }
        }
        .font(.callout)

        
        HStack(spacing: .zero) {
          Image(systemName: "plus.circle")
            .foregroundStyle(.spotifyLightGray)
            .font(.title3)
            .padding(4)
            .background(Color.black.opacity(0.001))
            .onTapGesture {
              onAddTapAction?()
            }
            .offset(x: -4)
            .frame(maxWidth: .infinity, alignment: .leading)
          
          Image(systemName: "play.circle.fill")
            .foregroundStyle(.spotifyWhite)
            .font(.title)
        }
        .onTapGesture {
          onPlayTapAction?()
        }
      }
      .padding(.trailing, 16)
    }
    .themeColor()
    .clipShape(RoundedRectangle(cornerRadius: 8))
  }
  
  func onAddTapAction(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onAddTapAction = action
    return newView
  }
  
  func onPlayTapAction(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onPlayTapAction = action
    return newView
  }
}

// MARK: - Preview

struct SpotifyNewReleaseCell_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      VStack {
        SpotifyNewReleaseCell(headline: "New release", subheadline: "Astrid S",
                              title: "Let come first", subTitle: "Single-Album")
      }
      .padding()
    }
  }
}
