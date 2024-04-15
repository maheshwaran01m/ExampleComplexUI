//
//  NetflixMovieView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 14/04/24.
//

import SwiftUI

struct NetflixMovieView: View {
  
  let width: CGFloat
  let height: CGFloat
  let imageName: String
  let title: String?
  let isRecentlyAdded: Bool
  let toTenRanking: Int?
  
  init(width: CGFloat = 90,
       height: CGFloat = 140,
       imageName: String = DatabaseHelper.imageURL,
       title: String? = "Movie title",
       isRecentlyAdded: Bool = true,
       toTenRanking: Int? = nil) {
    
    self.width = width
    self.height = height
    self.imageName = imageName
    self.title = title
    self.isRecentlyAdded = isRecentlyAdded
    self.toTenRanking = toTenRanking
  }
  
  var body: some View {
    HStack(alignment: .bottom, spacing: -8) {
      rankingView
      mainView
    }
  }
  
  private var mainView: some View {
    ZStack(alignment: .bottom) {
      ImageLoaderView(imageName)
      
      VStack(spacing: 0) {
        if let title, let firstword = title.components(separatedBy: " ").first {
          Text(firstword)
            .font(.subheadline)
            .fontWeight(.medium)
            .lineLimit(1)
        }
        
        Text("Recently Added")
          .padding(.horizontal, 4)
          .padding(.vertical, 2)
          .frame(maxWidth: .infinity)
          .background(.netflixRed, in: .rect(cornerRadius: 8))
          .lineLimit(1)
          .font(.caption2)
          .fontWeight(.bold)
          .minimumScaleFactor(0.1)
          .padding(.horizontal, 8)
          .opacity(isRecentlyAdded ? 1 : 0)
      }
      .padding(.top, 6)
      .background {
        LinearGradient(colors: [.netflixBlack.opacity(0),
                                .netflixBlack.opacity(0.3),
                                .netflixBlack.opacity(0.4)], startPoint: .top, endPoint: .bottom)
      }
    }
    .clipShape(.rect(cornerRadius: 8))
    .frame(width: width, height: height)
    .foregroundStyle(.netflixWhite)
  }
  
  @ViewBuilder
  private var rankingView: some View {
    if let toTenRanking {
      Text(toTenRanking.description)
        .font(.system(size: 100, weight: .medium, design: .serif))
        .foregroundStyle(.netflixWhite)
        .offset(y: 20)
    }
  }
}

// MARK: - Preview

struct NetflixMovieView_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.netflixBlack.ignoresSafeArea()
      NetflixMovieView()
    }
  }
}
