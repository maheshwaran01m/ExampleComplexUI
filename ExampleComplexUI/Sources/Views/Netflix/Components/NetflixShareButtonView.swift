//
//  NetflixShareButtonView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 14/04/24.
//

import SwiftUI

struct NetflixShareButtonView: View {
  
  let url: String
  
  init(url: String = "https://www.apple.com") {
    self.url = url
  }
  
  var body: some View {
    mainView
  }
  
  @ViewBuilder
  var mainView: some View {
    if let url = URL(string: url) {
      
      ShareLink(item: url) {
        VStack(spacing: 8) {
            Image(systemName: "square.and.arrow.up")
              
          .font(.title)
          
          Text("My List")
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
      }
    }
  }
}

// MARK: - Preview

struct NetflixShareButtonView_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      NetflixShareButtonView()
    }
  }
}
