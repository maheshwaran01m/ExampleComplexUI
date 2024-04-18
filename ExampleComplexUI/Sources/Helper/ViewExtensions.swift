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
  
  func getFrame(_ value: @escaping (CGRect) -> Void) -> some View {
    self.background {
      GeometryReader { proxy in
        Color.clear
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .onAppear {
            value(proxy.frame(in: .global))
          }
          .onChange(of: proxy.frame(in: .global)) {
            value($0)
          }
      }
    }
  }
  
  @ViewBuilder
  func isEnabled(_ show: Bool, _ content: (Self) -> some View) -> some View {
    if show {
      content(self)
    } else {
      self
    }
  }
}
