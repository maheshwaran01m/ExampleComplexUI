//
//  ExampleComplexUIApp.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 28/03/24.
//

import SwiftUI

@main
struct ExampleComplexUIApp: App {
  var body: some Scene {
    WindowGroup {
      let _ = print("Path: \(URL.libraryDirectory.path())")
      ContentView()
    }
  }
}
