//
//  NetflixRateButtonView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 14/04/24.
//

import SwiftUI

struct NetflixRateButtonView: View {
  
  var body: some View {
    
    VStack(spacing: 8) {
      
      Image(systemName: "hand.thumbsup")
        .font(.title)
      
      Text("Rate")
    }
    .foregroundStyle(.netflixWhite)
    .padding(8)
    .background(Color.black.opacity(0.01))
  }
}

// MARK: - Preview

struct NetflixRateButtonView_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      PreviewView()
    }
  }
  
  struct PreviewView: View {
    
    @State private var isMyList = false
    
    var body: some View {
      NetflixRateButtonView()
    }
  }
}
