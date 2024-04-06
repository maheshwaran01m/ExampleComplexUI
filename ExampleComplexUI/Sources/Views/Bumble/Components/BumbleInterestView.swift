//
//  BumbleInterestView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 06/04/24.
//

import SwiftUI

struct BumbleInterestView: View {
  
  let interests: [Item]
  
  init(interests: [Item] = User.preview.interests) {
    self.interests = interests
  }
  
  var body: some View {
    ZStack {
      NonLazyVGrid(columns: 2, alignment: .leading, spacing: 8,
                   items: interests) { item in
        if let item {
          BumbleChipView(iconName: item.iconName,
                         emoji: item.emoji, text: item.text)
        }
      }
    }
  }
}

extension BumbleInterestView {
  
  struct Item {
    let id = UUID().uuidString
    let iconName: String?
    let emoji: String?
    let text: String
    
    init(iconName: String? = nil,
         emoji: String? = nil,
         text: String) {
      self.iconName = iconName
      self.emoji = emoji
      self.text = text
    }
  }
}

// MARK: - Preview

struct BumbleInterestView_Previews: PreviewProvider {
  
  static var previews: some View {
    BumbleInterestView()
  }
}
