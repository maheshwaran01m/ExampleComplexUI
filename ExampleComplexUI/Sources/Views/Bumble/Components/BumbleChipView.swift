//
//  BumbleChipView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 06/04/24.
//

import SwiftUI

struct BumbleChipView: View {
  
  var iconName: String? = "heart.fill"
  var emoji: String? = "👋"
  var text = "Example Text"
  
  var body: some View {
    HStack(spacing: 4) {
      
      if let iconName {
        Image(systemName: iconName)
      } else if let emoji {
        Text(emoji)
      }
      
      Text(text)
    }
    .font(.callout)
    .fontWeight(.medium)
    .padding(.vertical, 6)
    .padding(.horizontal, 12)
    .foregroundStyle(.bumbleBlack)
    .background(.bumbleLightYellow, in: RoundedRectangle(cornerRadius: 16))
  }
}

// MARK: - Preview

struct BumbleChipView_Previews: PreviewProvider {
  
  static var previews: some View {
    BumbleChipView()
  }
}
