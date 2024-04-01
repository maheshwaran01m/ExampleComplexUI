//
//  SpotifyPlaylistDecriptionCell.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 31/03/24.
//

import SwiftUI

struct SpotifyPlaylistDecriptionCell: View {
  
  let descriptionText: String
  let userName: String
  let subheadline: String
  
  var onAddClicked: (() -> Void)?
  var onDownloadClicked: (() -> Void)?
  var onShareClicked: (() -> Void)?
  var onEllipsisClicked: (() -> Void)?
  var onShuffleClicked: (() -> Void)?
  var onPlayClicked: (() -> Void)?
  
  init(descriptionText: String = Product.preview.description,
       userName: String = Product.preview.title,
       subheadline: String = Product.preview.brand) {
    
    self.descriptionText = descriptionText
    self.userName = userName
    self.subheadline = subheadline
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      
      Text(descriptionText)
        .font(.caption)
        .foregroundStyle(.spotifyLightGray)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      
      detailView
      subtitleView
      bottomView
    }
    .font(.caption)
    .fontWeight(.medium)
    .foregroundStyle(.spotifyLightGray)
  }
  
  private var detailView: some View {
    HStack(spacing: 8) {
      Image(systemName: "apple.logo")
        .font(.title3)
        .foregroundStyle(.spotifyGreen)
      
      Text("Made for ") +
      Text(userName)
        .bold()
        .foregroundColor(.spotifyWhite)
    }
  }
  
  private var subtitleView: some View {
    Text(subheadline)
      .font(.caption)
      .foregroundStyle(.spotifyLightGray)
  }
  
  private var bottomView: some View {
    HStack(spacing: .zero) {
      
      HStack(spacing: .zero) {
        Image(systemName: "plus.circle")
          .padding(8)
          .background(Color.black.opacity(0.001))
          .onTapGesture {
            onAddClicked?()
          }
          
        Image(systemName: "arrow.down.circle")
          .padding(8)
          .background(Color.black.opacity(0.001))
          .onTapGesture {
            onDownloadClicked?()
          }
        
        Image(systemName: "square.and.arrow.up")
          .padding(8)
          .background(Color.black.opacity(0.001))
          .onTapGesture {
            onShareClicked?()
          }
        
        Image(systemName: "ellipsis")
          .padding(8)
          .background(Color.black.opacity(0.001))
          .onTapGesture {
            onEllipsisClicked?()
          }
      }
      .offset(x: -8)
      .frame(maxWidth: .infinity, alignment: .leading)
      
      
      HStack(spacing: 8) {
        
        Image(systemName: "shuffle")
          .font(.system(size: 24))
          .background(Color.black.opacity(0.001))
          .onTapGesture {
            onShareClicked?()
          }
        
        Image(systemName: "play.circle.fill")
          .font(.system(size: 46))
          .background(Color.black.opacity(0.001))
          .onTapGesture {
            onEllipsisClicked?()
          }
      }
      .foregroundStyle(.spotifyGreen)
    }
    .font(.title3)
  }
}

extension SpotifyPlaylistDecriptionCell {
  
  func onAddClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onAddClicked = action
    return newView
  }
  
  func onDownloadClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onDownloadClicked = action
    return newView
  }
  
  func onShareClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onShareClicked = action
    return newView
  }
  
  func onEllipsisClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onEllipsisClicked = action
    return newView
  }
  
  func onShuffleClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onShuffleClicked = action
    return newView
  }
  
  func onPlayClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onPlayClicked = action
    return newView
  }
}

// MARK: - Preview

struct SpotifyPlaylistDecriptionCell_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      SpotifyPlaylistDecriptionCell()
    }
  }
}
