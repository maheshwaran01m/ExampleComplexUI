//
//  ContentView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 28/03/24.
//

import SwiftUI

struct ContentView: View {
    
  var body: some View {
    NavigationStack {
      SpotifyHomeView()
    }
  }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    NavigationStack {
      ContentView()
    }
  }
}
