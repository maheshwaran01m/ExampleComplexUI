//
//  BumbleHomeView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 06/04/24.
//

import SwiftUI

struct BumbleHomeView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @AppStorage("bumble_home_filter") private var filter: String = "Everyone"
  
  @State private var records = [User]()
  
  @State private var selectedIndex = 0
  
  /// (key: userID, value: direction right is true)
  @State private var cardOffsets = [Int: Bool]()
  
  @State private var currentSwipeOffset = CGFloat.zero
  
  var body: some View {
    ZStack {
      Color.bumbleWhite.ignoresSafeArea()
      
      mainView
    }
    .toolbar(.hidden, for: .navigationBar)
    .task { await getData() }
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
        
        NavigationLink {
          BumbleChatView()
        } label: {
          Image(systemName: "line.horizontal.3")
            .padding(8)
            .background(Color.bumbleBlack.opacity(0.0001))
          
        }
        
        Image(systemName: "arrow.uturn.left")
          .padding(8)
          .background(Color.bumbleBlack.opacity(0.0001))
          .onTapGesture {
            dismiss()
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
    ZStack {
      if !records.isEmpty {
        detailView
      } else {
        ProgressView()
      }
      overlaySwipeView
    }
    .frame(maxHeight: .infinity)
    .padding(4)
    .animation(.smooth, value: cardOffsets)
  }
  
  // MARK: - Card View
  
  private var detailView: some View {
    ForEach(Array(records.enumerated()), id: \.offset) { (index, user) in
      
      let isPrevious = (selectedIndex-1) == index
      let isCurrent = selectedIndex == index
      let nextIndex = (selectedIndex+1) == index
      
      if isPrevious || isCurrent || nextIndex {
        
        let offsetValue = cardOffsets[user.id]
        
        BumbleCardView(user: records[index])
          .onCloseClicked {
            userSelection(index, isLiked: false)
          }
          .onCheckMarkClicked {
            userSelection(index, isLiked: true)
          }
          .withDragGesture(
            .horizontal, 
            minimumDistance: 10,
            rotationMultiplier: 1.05,
            onChanged: { dragOffset in
              
              currentSwipeOffset = dragOffset.width
              
            }, onEnded: { dragOffset in
              
              if dragOffset.width < -50 {
                userSelection(index, isLiked: false)
              } else if dragOffset.width > 50 {
                userSelection(index, isLiked: true)
              }
            })
          .zIndex(Double(records.count-index))
          .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 900 : -900)
      }
    }
  }
  
  private func userSelection(_ index: Int, isLiked: Bool) {
    let user = records[index]
    cardOffsets[user.id] = isLiked
    
    selectedIndex += 1
  }
  
  private var overlaySwipeView: some View {
    ZStack {
      Circle()
        .fill(Color.bumbleGray.opacity(0.4))
        .overlay {
          Image(systemName: "xmark")
            .font(.title)
            .fontWeight(.semibold)
        }
        .frame(width: 60, height: 60)
        .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1)
        .offset(x: min(-currentSwipeOffset, 150))
        .offset(x: -100)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      
      Circle()
        .fill(Color.bumbleGray.opacity(0.4))
        .overlay {
          Image(systemName: "checkmark")
            .font(.title)
            .fontWeight(.semibold)
        }
        .frame(width: 60, height: 60)
        .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1)
        .offset(x: max(-currentSwipeOffset, -150))
        .offset(x: +100)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
      .zIndex(999)
      .animation(.smooth, value: currentSwipeOffset)
  }
}

// MARK: - Get Data

extension BumbleHomeView {
  
  private func getData() async {
    do {
      records = try await DatabaseHelper().getUsers()
    } catch {}
  }
}

// MARK: - Preview

struct BumbleHomeView_Previews: PreviewProvider {
  
  static var previews: some View {
    NavigationStack {
      BumbleHomeView()
    }
  }
}
