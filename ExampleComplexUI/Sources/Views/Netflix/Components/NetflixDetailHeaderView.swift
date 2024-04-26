//
//  NetflixDetailHeaderView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 14/04/24.
//

import SwiftUI

struct NetflixDetailHeaderView: View {
  
  let imageName: String
  let progress: Double
  
  var onAirPlayClicked: (() -> Void)?
  var onCloseClicked: (() -> Void)?
  
  init(imageName: String = DatabaseHelper.imageURL,
       progress: Double = 0.2) {
    
    self.imageName = imageName
    self.progress = progress
  }
  
  var body: some View {
    ZStack(alignment: .bottom) {
      ImageLoaderView(imageName)
      
      CustomProgressBar(selection: progress, range: 0...1,
                        backgroundColor: .netflixLightGray,
                        foregroundColor: .netflixRed,
                        cornerRadius: 2, height: 4)
      .padding(.bottom, 4)
      .animation(.linear, value: progress)
      
      HStack(spacing: 8) {
        Circle()
          .fill(.netflixDarkGray)
          .overlay {
            Image(systemName: "tv.badge.wifi")
              .offset(y: 1)
              .onTapGesture { onAirPlayClicked?() }
          }
          .frame(width: 36, height: 36)
        
        Circle()
          .fill(.netflixDarkGray)
          .overlay {
            Image(systemName: "xmark")
              .offset(y: 1)
              .onTapGesture { onCloseClicked?() }
          }
          .frame(width: 36, height: 36)
      }
      .foregroundStyle(.netflixWhite)
      .font(.subheadline)
      .fontWeight(.bold)
      .padding(8)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
    .aspectRatio(2, contentMode: .fit)
  }
}

extension NetflixDetailHeaderView {
  
  func onAirPlayClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onAirPlayClicked = action
    return newView
  }
  
  func close(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onCloseClicked = action
    return newView
  }
}

// MARK: - Preview

struct NetflixDetailHeaderView_Previews: PreviewProvider {
  
  static var previews: some View {
    NetflixDetailHeaderView()
  }
}
