//
//  SpotifySongRowCell.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 01/04/24.
//

import SwiftUI

struct SpotifySongRowCell: View {
  
  let imageSize: CGFloat
  let imageName: String
  let title: String
  let subtitle: String?
  
  var action: (() -> ())?
  var onEllipsisAction: (() -> ())?
  
  init(imageName: String = DatabaseHelper.imageURL,
       imageSize: CGFloat = 100,
       title: String = "Example",
       subtitle: String? = "Subtitle") {
    self.imageSize = imageSize
    self.imageName = imageName
    self.title = title
    self.subtitle = subtitle
  }
  
  var body: some View {
    HStack(spacing: 8) {
      ImageLoaderView(imageName)
        .frame(width: imageSize, height: imageSize)
      
      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .font(.body)
          .fontWeight(.medium)
          .foregroundStyle(.spotifyWhite)
        
        if let subtitle {
          Text(subtitle)
            .font(.callout)
            .foregroundStyle(.spotifyLightGray)
        }
      }
      .lineLimit(2)
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Image(systemName: "ellipsis")
        .font(.subheadline)
        .foregroundStyle(.spotifyWhite)
        .padding(16)
        .onTapGesture {
          onEllipsisAction?()
        }
    }
  }
}

extension SpotifySongRowCell {
  
  func action(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.action = action
    return newView
  }
  
  func onEllipsisAction(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onEllipsisAction = action
    return newView
  }
}

// MARK: - Preview

struct SpotifySongRowCell_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      VStack {
        ForEach(0..<10) { index in
          SpotifySongRowCell()
        }
      }
      .padding()
    }
  }
}
