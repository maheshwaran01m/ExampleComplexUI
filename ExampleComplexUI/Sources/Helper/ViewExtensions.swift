//
//  ViewExtensions.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 06/04/24.
//

import SwiftUI

extension View {
  
  func getFrame(_ value: Binding<CGRect>) -> some View {
    self.background {
      GeometryReader { proxy in
        Color.clear
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .onAppear {
            value.wrappedValue = proxy.frame(in: .global)
          }
          .onChange(of: proxy.frame(in: .global)) {
            value.wrappedValue = $0
          }
      }
    }
  }
}