//
//  NetflixListButtonView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 14/04/24.
//

import SwiftUI

struct NetflixListButtonView: View {
  
  let isMyList: Bool
  let action: (() -> Void)?
  
  init(isMyList: Bool = false, action: (() -> Void)? = nil) {
    self.isMyList = isMyList
    self.action = action
  }
  
  var body: some View {
    VStack(spacing: 8) {
      ZStack {
        Image(systemName: "checkmark")
          .opacity(isMyList ? 1 : 0)
          .rotationEffect(.degrees(isMyList ? 0 : 180))
        
        Image(systemName: "plus")
          .opacity(isMyList ? 0 : 1)
          .rotationEffect(.degrees(isMyList ? -180 : 0))
      }
      .font(.title)
      
      Text("My List")
    }
    .foregroundStyle(.netflixWhite)
    .padding(8)
    .background(Color.black.opacity(0.01))
    .animation(.bouncy, value: isMyList)
    .onTapGesture { action?() }
  }
}

// MARK: - Preview

struct NetflixListButtonView_Previews: PreviewProvider {
  
  static var previews: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      PreviewView()
    }
  }
  
  struct PreviewView: View {
    
    @State private var isMyList = false
    
    var body: some View {
      NetflixListButtonView(isMyList: isMyList) {
        isMyList.toggle()
      }
    }
  }
}
