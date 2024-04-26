//
//  NetflixDetailProductView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 14/04/24.
//

import SwiftUI

struct NetflixDetailProductView: View {
  
  let title: String
  let isNew: Bool
  let yearReleased: String
  let seasonCount: Int?
  let hasClosedCaption: Bool
  let isTopTen: Int?
  let description: String?
  
  let castText: String?
  var onPlayClicked: (() -> Void)?
  var onDownloadClicked: (() -> Void)?
  
  init(title: String = "Movie",
       isNew: Bool = true,
       yearReleased: String = "2024",
       seasonCount: Int? = 2,
       hasClosedCaption: Bool = true,
       isTopTen: Int? = 6,
       description: String? = "Example for description",
       castText: String? = "Case: People") {
    self.title = title
    self.isNew = isNew
    self.yearReleased = yearReleased
    self.seasonCount = seasonCount
    self.hasClosedCaption = hasClosedCaption
    self.isTopTen = isTopTen
    self.description = description
    self.castText = castText
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      titleView
      headerView
      headerDetailView
      buttonView
      descriptionView
    }
    .foregroundStyle(.netflixWhite)
  }
  
  private var titleView: some View {
    Text(title)
      .font(.headline)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var headerView: some View {
    HStack(spacing: 8) {
      if isNew {
        Text("New")
          .foregroundStyle(.green)
      }
      
      Text(yearReleased)
      
      if let seasonCount {
        Text("\(seasonCount) Season")
      }
      
      if hasClosedCaption {
        Image(systemName: "captions.bubble")
      }
    }
    .foregroundStyle(.netflixLightGray)
  }

  @ViewBuilder
  private var headerDetailView: some View {
    if let isTopTen {
      HStack(spacing: 8) {
        
        Rectangle()
          .fill(.netflixRed)
          .frame(width: 28, height: 28)
          .overlay {
            VStack(spacing: -4) {
              Text("TOP")
                .fontWeight(.bold)
                .font(.system(size: 8))
              
              Text("10")
                .fontWeight(.bold)
                .font(.system(size: 16))
            }
            .offset(y: 1)
          }
        
        Text("\(isTopTen) in TV Shows Today")
          .font(.headline)
      }
    }
  }
  
  private var buttonView: some View {
    VStack(spacing: 8) {
      HStack {
        Image(systemName: "play.fill")
        Text("Play")
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical, 8)
      .foregroundStyle(.netflixDarkGray)
      .background(.netflixWhite)
      .clipShape(.rect(cornerRadius: 8))
      .onTapGesture { onPlayClicked?() }
      
      
      HStack {
        Image(systemName: "arrow.down.to.line.alt")
        Text("Download")
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical, 8)
      .foregroundStyle(.netflixWhite)
      .background(.netflixDarkGray)
      .clipShape(.rect(cornerRadius: 8))
      .onTapGesture { onDownloadClicked?() }
    }
    .font(.callout)
    .fontWeight(.medium)
  }
  
  private var descriptionView: some View {
    Group {
      if let description {
        Text(description)
      }
      
      if let castText {
        Text(castText)
          .foregroundStyle(.netflixLightGray)
      }
    }
    .font(.callout)
    .frame(maxWidth: .infinity, alignment: .leading)
    .multilineTextAlignment(.leading)
  }

}

extension NetflixDetailProductView {
  
  func onPlayClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onPlayClicked = action
    return newView
  }
  
  func onDownloadClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onDownloadClicked = action
    return newView
  }
}

// MARK: - Preview

struct NetflixDetailProductView_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.netflixBlack.ignoresSafeArea()
      
      NetflixDetailProductView()
    }
  }
}
