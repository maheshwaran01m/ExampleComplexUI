//
//  BumbleChatPreviewView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 06/04/24.
//

import SwiftUI

struct BumbleChatPreviewView: View {
  
  let imageName: String
  let percentageRemaining: Double
  let hasMessage: Bool
  
  let userName: String
  let message: String?
  let hasYourMove: Bool
  
  init(_ imageName: String = DatabaseHelper.imageURL,
       percentageRemaining: Double = Double.random(in: 0...1),
       hasMessage: Bool = true,
       userName: String = "User",
       message: String? = "This is the lastest message",
       hasYourMove: Bool = true) {
    self.imageName = imageName
    self.percentageRemaining = 0.4// percentageRemaining
    self.hasMessage = hasMessage
    self.userName = userName
    self.message = message
    self.hasYourMove = hasYourMove
  }
  
  var body: some View {
    HStack(spacing: 16) {
      BumbleProfileView(
        imageName,
        percentageRemaining: percentageRemaining,
        hasMessage: hasMessage)
      
      
      mainView
    }
  }
  
  private var mainView: some View {
    VStack(alignment: .leading, spacing: 2) {
      HStack(spacing: .zero) {
        Text(userName)
          .font(.headline)
          .foregroundStyle(.bumbleBlack)
          .frame(maxWidth: .infinity, alignment: .leading)
        
        if hasYourMove {
          Text("Your Move")
            .font(.caption)
            .bold()
            .padding(.vertical, 4)
            .padding(.horizontal, 6)
            .background(Color.bumbleYellow, in: RoundedRectangle(cornerRadius: 16))
        }
      }
      
      if let message {
        Text(message)
          .font(.subheadline)
          .foregroundStyle(.bumbleGray)
          .padding(.trailing, 16)
      }
    }
    .lineLimit(1)
  }
}

// MARK: - Preview

struct BumbleChatPreviewView_Previews: PreviewProvider {
  
  static var previews: some View {
    BumbleChatPreviewView()
  }
}
