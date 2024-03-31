//
//  SpotifyCategoryCell.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 31/03/24.
//

import SwiftUI

struct SpotifyCategoryCell: View {
  
  let title: String
  let isSelected: Bool
  
  init(_ title: String = "", isSelected: Bool = false) {
    self.title = title
    self.isSelected = isSelected
  }
  
  var body: some View {
    Text(title)
      .font(.callout)
      .frame(minWidth: 35)
      .padding(.vertical, 8)
      .padding(.horizontal, 10)
      .themeColor(isSelected)
      .clipShape(RoundedRectangle(cornerRadius: 16))
  }
}

extension View {
  
  func themeColor(_ isSelected: Bool = false) -> some View {
    self
      .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
      .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
  }
}

// MARK: - Preview

struct SpotifyCategoryCell_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      VStack {
        SpotifyCategoryCell("Title", isSelected: true)
        SpotifyCategoryCell("Subtitle")
      }
    }
  }
}
