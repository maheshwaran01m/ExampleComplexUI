//
//  ContentView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 28/03/24.
//

import SwiftUI

struct ContentView: View {
  
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .padding()
  }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    ContentView()
  }
}
