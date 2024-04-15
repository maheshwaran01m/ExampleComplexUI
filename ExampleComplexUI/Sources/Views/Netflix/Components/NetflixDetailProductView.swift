//
//  NetflixDetailProductView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 14/04/24.
//

import SwiftUI

struct NetflixDetailProductView: View {
  
  let title: String
  let isNew: Bool
  let yearReleased: String
  let seasonCount: Int?
  let hasClosedCaption: Bool
  let isTopTen: Int?
  let description: String
  
  let castText: String
  var onPlayClicked: (() -> Void)?
  var onDownloadClicked: (() -> Void)?
  
  init(title: String = "Movie",
       isNew: Bool = true,
       yearReleased: String = "2024",
       seasonCount: Int? = 2,
       hasClosedCaption: Bool = true,
       isTopTen: Int? = 6,
       description: String = "Example for description",
       castText: String = "Case: People") {
    self.title = title
    self.isNew = isNew
    self.yearReleased = yearReleased
    self.seasonCount = seasonCount
    self.hasClosedCaption = hasClosedCaption
    self.isTopTen = isTopTen
    self.description = description
    self.castText = castText
  }
  
  var body: some View {
    VStack {
      
    }
  }
}

extension NetflixDetailProductView {
  
  func onPlayClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onPlayClicked = action
    return newView
  }
  
  func onDownloadClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onDownloadClicked = action
    return newView
  }
}

// MARK: - Preview

struct NetflixDetailProductView_Previews: PreviewProvider {
  
  static var previews: some View {
    NetflixDetailProductView()
  }
}
