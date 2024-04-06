//
//  BumbleCardView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 06/04/24.
//

import SwiftUI

struct BumbleCardView: View {
  
  private let user: User
  
  @State private var frame = CGRect.zero
  
  private var onSuperLikeClicked: (() -> Void)?
  private var onCloseClicked: (() -> Void)?
  private var onCheckMarkClicked: (() -> Void)?
  private var onSendComplimentClicked: (() -> Void)?
  private var onHideAndReportClicked: (() -> Void)?

  
  init(user: User = .preview) {
    self.user = user
  }
  
  var body: some View {
    ScrollView {
      LazyVStack(spacing: 0) {
        headerView
        detailView
        footerView
        imageViews
        bottomView
        bottomButtonView
      }
    }
    .overlay(alignment: .bottomTrailing, content: overlayView)
    .background(Color.bumbleBackgroundYellow)
    .clipShape(RoundedRectangle(cornerRadius: 32))
    .getFrame($frame)
    .scrollIndicators(.hidden)
  }
  
  private var headerView: some View {
    ZStack(alignment: .bottomLeading) {
      ImageLoaderView(user.image)
       
      VStack(alignment: .leading, spacing: 8) {
        Text(user.firstName + " \(user.age)")
          .font(.largeTitle)
          .fontWeight(.semibold)
        
        HStack(spacing: 4) {
          Image(systemName: "suitcase")
          Text(user.work)
        }
        
        HStack(spacing: 4) {
          Image(systemName: "graduationcap")
          Text(user.education)
        }
        
        BumbleHeartView()
          .onTapGesture {
            
          }
      }
      .padding(24)
      .font(.callout)
      .fontWeight(.medium)
      .foregroundStyle(.bumbleWhite)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(
        LinearGradient(colors: [.bumbleBlack.opacity(0),
                                .bumbleBlack.opacity(0.6),
                                .bumbleBlack.opacity(0.6)],
                       startPoint: .top, endPoint: .bottom)
      
      )
    }
    .frame(height: frame.height)
  }
  
  private var detailView: some View {
    VStack(alignment: .leading, spacing: 12) {
      
      Text("About Me")
        .font(.body)
        .foregroundStyle(.bumbleGray)
      
      Text(user.aboutMe)
        .font(.body)
        .fontWeight(.semibold)
        .foregroundStyle(.bumbleBlack)
      
      HStack(spacing: .zero) {
        BumbleHeartView()
        
        Text("Send a compliment")
          .font(.caption)
          .fontWeight(.semibold)
      }
      .padding([.horizontal, .trailing], 8)
      .background(Color.bumbleYellow)
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .onTapGesture {
        onSendComplimentClicked?()
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(24)
  }
  
  private var footerView: some View {
    VStack(alignment: .leading, spacing: 12) {
      
      VStack(alignment: .leading, spacing: 8) {
        Text("My Basics")
          .font(.body)
          .foregroundStyle(.bumbleGray)
        
        BumbleInterestView(interests: user.basic)
      }
      
      VStack(alignment: .leading, spacing: 8) {
        Text("My Interest")
          .font(.body)
          .foregroundStyle(.bumbleGray)
        
        BumbleInterestView(interests: user.interests)
      }
    }
    .padding(24)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var imageViews: some View {
    ForEach(user.images, id: \.self) { image in
      ImageLoaderView(image)
        .frame(height: frame.height)
    }
  }
  
  private var bottomView: some View {
    VStack(alignment: .leading, spacing: 12) {
      
      HStack(spacing: 8) {
        Image(systemName: "mappin.and.ellipse.circle.fill")
        Text(user.firstName + "'s Location")
      }
      .foregroundStyle(.bumbleGray)
      .font(.body)
      .fontWeight(.medium)
      
      Text("10 miles away")
        .font(.headline)
        .foregroundStyle(.bumbleBlack)
      
      BumbleChipView(iconName: "star", text: "Lives in Earth")
    }
    .padding(24)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var bottomButtonView: some View {
    VStack(spacing: 24) {
      
      HStack(spacing: .zero) {
        Circle()
          .fill(Color.bumbleYellow)
          .overlay {
            Image(systemName: "xmark")
              .font(.title)
              .fontWeight(.bold)
          }
          .frame(width: 60, height: 60)
          .onTapGesture {
            onCloseClicked?()
          }
        
        Spacer(minLength: 0)
        
        Circle()
          .fill(Color.bumbleYellow)
          .overlay {
            Image(systemName: "checkmark")
              .font(.title)
              .fontWeight(.bold)
          }
          .frame(width: 60, height: 60)
          .onTapGesture {
            onCheckMarkClicked?()
          }
      }
      
      Text("Hide and Report")
        .font(.headline)
        .foregroundStyle(.bumbleGray)
        .padding(8)
        .background(Color.bumbleBlack.opacity(0.01))
        .onTapGesture {
          onHideAndReportClicked?()
        }
    }
    .padding(24)
  }
  
  private func overlayView() -> some View {
    Image(systemName: "hexagon.fill")
      .foregroundStyle(.bumbleYellow)
      .font(.system(size: 60))
      .overlay {
        Image(systemName: "star.fill")
          .foregroundStyle(.bumbleBlack)
          .font(.system(size: 30, weight: .medium))
      }
      .padding(12)
      .onTapGesture {
        onSuperLikeClicked?()
      }
  }
}

extension BumbleCardView {
  
  func onSuperLikeClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onSuperLikeClicked = action
    return newView
  }
  
  func onCloseClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onCloseClicked = action
    return newView
  }
  
  func onCheckMarkClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onCheckMarkClicked = action
    return newView
  }
  
  func onSendComplimentClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onSendComplimentClicked = action
    return newView
  }
  
  func onHideAndReportClicked(_ action: @escaping () -> Void) -> Self {
    var newView = self
    newView.onHideAndReportClicked = action
    return newView
  }
}

// MARK: - Preview

struct BumbleCardView_Previews: PreviewProvider {
  
  static var previews: some View {
    BumbleCardView()
      .padding(.vertical, 40)
      .padding(.horizontal, 16)
  }
}
