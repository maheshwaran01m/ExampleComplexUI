//
//  ContentView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 28/03/24.
//

import SwiftUI

struct ContentView: View {
  
  @State private var users = [User]()
  
  var body: some View {
    List(users, id: \.id) { user in
      Text(user.firstName)
    }
    .task {
      await getData()
    }
  }
  
  private func getData() async {
    do {
      users = try await DatabaseHelper().getUsers()
    } catch {
      
    }
  }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    ContentView()
  }
}
