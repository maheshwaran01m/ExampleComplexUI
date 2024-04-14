//
//  NetflixMainView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 13/04/24.
//

import SwiftUI

struct NetflixMainView: View {
  
  let imageName: String
  let isNetflixFilm: Bool
  let title: String
  let categories: [String]
  
  var onBackgroundClicked: (() -> Void)?
  var onPlayClicked: (() -> Void)?
  var onMyListClicked: (() -> Void)?
  
  init(imageName: String = DatabaseHelper.imageURL,
       isNetflixFilm: Bool = true,
       title: String = "Players",
       categories: [String] = ["Romantic", "Comedy", "Sci-fi"]) {
    
    self.imageName = imageName
    self.isNetflixFilm = isNetflixFilm
    self.title = title
    self.categories = categories
  }
  
  var body: some View {
    ZStack(alignment: .bottom) {
      ImageLoaderView(imageName)
      
      VStack(spacing: 16) {
        
        VStack(spacing: 0) {
          if isNetflixFilm {
            HStack(spacing: 8) {
              Text("N")
                .foregroundStyle(.netflixRed)
                .font(.largeTitle)
                .fontWeight(.black)
              
              Text("FILM")
                .kerning(3)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.netflixWhite)
            }
          }
          
          Text(title)
            .font(.system(size: 50, weight: .medium, design: .serif))
        }
        
        HStack(spacing: 8) {
          ForEach(categories, id: \.self) { category in
            Text(category)
              .font(.callout)
            
            if category != categories.last {
              Circle()
                .frame(width: 4, height: 4)
            }
          }
        }
        
        HStack(spacing: 16) {
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
            Image(systemName: "plus")
            Text("My List")
          }
          .frame(maxWidth: .infinity)
          .padding(.vertical, 8)
          .foregroundStyle(.netflixDarkGray)
          .background(.netflixWhite)
          .clipShape(.rect(cornerRadius: 8))
          .onTapGesture { onMyListClicked?() }
        }
        .font(.callout)
        .fontWeight(.medium)
      }
      .padding(24)
      .background {
        LinearGradient(
          colors: [.netflixBlack.opacity(0),
                   .netflixBlack.opacity(0.4),
                   .netflixBlack.opacity(0.4)],
          startPoint: .top, endPoint: .bottom)
      }
    }
    .foregroundStyle(.netflixWhite)
    .clipShape(.rect(cornerRadius: 8))
      .aspectRatio(0.8, contentMode: .fit)
      .onTapGesture { onBackgroundClicked?() }
  }
}

extension NetflixMainView {
  
  func onBackgroundClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onBackgroundClicked = action
    return newView
  }
  
  func onPlayClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onPlayClicked = action
    return newView
  }
  
  func onMyListClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onMyListClicked = action
    return newView
  }
}

// MARK: - Preview

struct NetflixMainView_Previews: PreviewProvider {
  
  static var previews: some View {
    NetflixMainView()
      .padding(40)
  }
}
