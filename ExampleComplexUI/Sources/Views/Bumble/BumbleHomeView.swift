//
//  BumbleHomeView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 06/04/24.
//

import SwiftUI

struct BumbleHomeView: View {
  
  @AppStorage("bumble_home_filter") private var filter: String = "Everyone"
  
  var body: some View {
    ZStack {
      Color.bumbleWhite.ignoresSafeArea()
      
      mainView
    }
  }
  
  private var mainView: some View {
    VStack(spacing: 8) {
      headerView
      filterView
      contentView
    }
    .padding(8)
  }
  
  private var headerView: some View {
    HStack(spacing: .zero) {
      
      HStack(spacing: .zero) {
        
        Image(systemName: "line.horizontal.3")
          .padding(8)
          .background(Color.bumbleBlack.opacity(0.0001))
          .onTapGesture {
            
          }
        
        Image(systemName: "arrow.uturn.left")
          .padding(8)
          .background(Color.bumbleBlack.opacity(0.0001))
          .onTapGesture {
            
          }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Text("Bumble")
        .font(.title)
        .foregroundStyle(.bumbleYellow)
        .frame(maxWidth: .infinity)
      
      Image(systemName: "slider.horizontal.3")
        .padding(8)
        .background(Color.bumbleBlack.opacity(0.0001))
        .onTapGesture {
          
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    .font(.title2)
    .fontWeight(.medium)
    .foregroundStyle(.bumbleBlack)
  }

  private var filterView: some View {
    BumbleFilterView(["Everyone", "Trending"],
                     selection: $filter)
    .background(alignment: .bottom) { Divider() }
  }

  private var contentView: some View {
    BumbleCardView()
  }
}

// MARK: - Preview

struct BumbleHomeView_Previews: PreviewProvider {
  
  static var previews: some View {
    BumbleHomeView()
  }
}
