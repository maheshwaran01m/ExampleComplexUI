//
//  BumbleProfileView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 06/04/24.
//

import SwiftUI

struct BumbleProfileView: View {
  
  let imageName: String
  let percentageRemaining: Double
  let hasMessage: Bool
  
  init(_ imageName: String = DatabaseHelper.imageURL,
       percentageRemaining: Double = Double.random(in: 0...1),
       hasMessage: Bool = true) {
    self.imageName = imageName
    self.percentageRemaining = 0.4// percentageRemaining
    self.hasMessage = hasMessage
  }
  
  var body: some View {
    ZStack {
      Circle()
        .stroke(.bumbleGray, lineWidth: 2)
      
      Circle()
        .trim(from: 0, to: percentageRemaining)
        .stroke(.bumbleYellow, lineWidth: 4)
        .rotationEffect(.degrees(-90))
        .scaleEffect(x: -1, y: 1, anchor: .center) // flip
      
      ImageLoaderView(imageName)
        .clipShape(.circle)
        .padding(5)
    }
    .frame(width: 75, height: 75)
    .overlay(alignment: .bottomTrailing, content: indicatorView)
  }
  
  private func indicatorView() -> some View {
    ZStack {
      if hasMessage {
        Circle()
          .fill(Color.bumbleWhite)
        
        Circle()
          .fill(Color.bumbleYellow)
          .padding(4)
      }
    }
    .frame(width: 24, height: 24)
    .offset(x: 2, y: 2)
  }

}

// MARK: - Preview

struct BumbleProfileView_Previews: PreviewProvider {
  
  static var previews: some View {
    BumbleProfileView()
  }
}
