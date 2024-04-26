//
//  NetflixRateButtonView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 14/04/24.
//

import SwiftUI

struct NetflixRateButtonView: View {
  
  @State private var showPopover = false
  
  var onRatingSelected: ((RateOption) -> Void)?
  
  var body: some View {
    
    VStack(spacing: 8) {
      
      Image(systemName: "hand.thumbsup")
        .font(.title)
      
      Text("Rate")
    }
    .foregroundStyle(.netflixWhite)
    .padding(8)
    .background(Color.black.opacity(0.01))
    .onTapGesture { showPopover.toggle() }
    .popover(isPresented: $showPopover, content: popOverView)
  }
  
  @ViewBuilder
  private func popOverView() -> some View {
    if #available(iOS 16.4, *) {
      popOverContentView
        .presentationCompactAdaptation(.popover)
    } else {
      popOverContentView
    }
  }
  
  private var popOverContentView: some View {
    ZStack {
      Color.netflixDarkGray.ignoresSafeArea()
      
      HStack(spacing: 12) {
        ForEach(RateOption.allCases, id: \.self) { rate in
          buttonView(rate) {
            showPopover.toggle()
            onRatingSelected?(rate)
          }
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 8)
    }
  }
  
  private func buttonView(_ rate: RateOption,
                          action: @escaping () -> Void = {}) -> some View {
    VStack(spacing: 8) {
      Image(systemName: rate.icon)
        .font(.title2)
      
      Text(rate.title)
        .font(.caption)
    }
    .foregroundStyle(.netflixWhite)
    .padding(4)
    .background(Color.black.opacity(0.001))
    .onTapGesture {
      
    }
  }
  
  enum RateOption: CaseIterable {
    case dislike, like, love
    
    var title: String {
      switch self {
      case .dislike: return "Not for me"
      case .like: return "I like this"
      case .love: return "Love this!"
      }
    }
    
    var icon: String {
      switch self {
      case .dislike: return "hand.thumbsdown"
      case .like: return "hand.thumbsup"
      case .love: return "bolt.heart"
      }
    }
  }
}

extension NetflixRateButtonView {
  
  func onRatingSelected(_ action: @escaping (RateOption) -> Void) -> Self {
    var newView = self
    newView.onRatingSelected = action
    return newView
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
