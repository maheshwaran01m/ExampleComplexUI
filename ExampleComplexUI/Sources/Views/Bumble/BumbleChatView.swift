//
//  BumbleChatView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 06/04/24.
//

import SwiftUI

struct BumbleChatView: View {
  
  @Environment(\.dismiss) private var dismiss
  @State private var users = [User]()
  
  var body: some View {
    ZStack {
      Color.bumbleWhite.ignoresSafeArea()
      
      mainView
    }
    .toolbar(.hidden, for: .navigationBar)
    .task { await getData() }
  }
  
  private var mainView: some View {
    VStack(spacing: .zero) {
      headerView
      matchQueueView
      chatView
    }
  }
  
  private var headerView: some View {
    HStack(spacing: .zero) {
      Image(systemName: "chevron.left")
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
          dismiss()
        }
      
      Image(systemName: "magnifyingglass")
    }
    .font(.title)
    .fontWeight(.medium)
    .padding(16)
  }
  
  private var matchQueueView: some View {
    VStack(alignment: .leading, spacing: 8) {
      Group {
        Text("Match Queue") +
        Text(" (\(users.count))")
          .foregroundColor(.bumbleGray)
      }
      .padding(.horizontal, 16)
      
      ScrollView(.horizontal) {
        LazyHStack(spacing: 16) {
          ForEach(users, id: \.self) { user in
            BumbleProfileView(
              user.image,
              percentageRemaining: .random(in: 0...1),
              hasMessage: .random())
          }
        }
        .padding(.horizontal, 16)
      }
      .scrollIndicators(.hidden)
      .frame(height: 100)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var chatView: some View {
    VStack(alignment: .leading, spacing: 8) {
      
      HStack(spacing: 0) {
        Group {
          Text("Chats") +
          Text(" (Recent)")
            .foregroundColor(.bumbleGray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Image(systemName: "line.horizontal.3.decrease")
          .font(.title2)
      }
      .padding(.horizontal, 16)
      
      ScrollView {
        LazyVStack(spacing: 16) {
          ForEach(users, id: \.self) { user in
            
            BumbleChatPreviewView(
              user.image,
              percentageRemaining: .random(in: 0...1),
              hasMessage: .random(),
              userName: user.firstName,
              message: user.aboutMe,
              hasYourMove: .random())
          }
        }
        .padding(16)
      }
      .scrollIndicators(.hidden)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

// MARK: - Get Data

extension BumbleChatView {
  
  private func getData() async {
    do {
      users = try await DatabaseHelper().getUsers()
    } catch {}
  }
}

// MARK: - Preview

struct BumbleChatView_Previews: PreviewProvider {
  
  static var previews: some View {
    BumbleChatView()
  }
}
