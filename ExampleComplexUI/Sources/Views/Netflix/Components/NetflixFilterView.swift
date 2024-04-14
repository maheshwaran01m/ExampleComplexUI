//
//  NetflixFilterView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 13/04/24.
//

import SwiftUI

struct NetflixFilterView: View {
  
  var title: String = "Categories"
  var isDropdown = true
  var isSelected = false
  
  var body: some View {
    HStack(spacing: 4) {
      Text(title)
      
      if isDropdown {
        Image(systemName: "chevron.down")
      }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 8)
    .background(content: backgroundStyle)
    .foregroundStyle(.netflixLightGray)
  }
  
  private func backgroundStyle() -> some View {
    ZStack {
      Capsule(style: .circular)
        .fill(.netflixDarkGray)
        .opacity(isSelected ? 1 : 0)
      
      Capsule()
        .stroke(lineWidth: 1)
    }
  }
}

// MARK: - Preview

struct NetflixFilterView_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.netflixBlack.ignoresSafeArea()
      
      NetflixFilterView()
    }
  }
}
