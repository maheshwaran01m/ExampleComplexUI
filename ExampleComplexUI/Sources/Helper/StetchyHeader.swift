//
//  StetchyHeader.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 31/03/24.
//

import SwiftUI

struct StetchyHeader: ViewModifier {
  
  var startingHeight: CGFloat = 300
  var coordinateSpace: CoordinateSpace
  
  init(height: CGFloat, coordinateSpace: CoordinateSpace = .global) {
    startingHeight = height
    self.coordinateSpace = coordinateSpace
  }
  
  func body(content: Content) -> some View {
    GeometryReader { proxy in
      content
        .frame(width: proxy.size.width, height: stretchedHeight(proxy))
        .clipped()
        .offset(y: stretchedOffset(proxy))
    }
    .frame(height: startingHeight)
  }
  
  private func yOffset(_ proxy: GeometryProxy) -> CGFloat {
    proxy.frame(in: coordinateSpace).minY
  }
  
  private func stretchedHeight(_ proxy: GeometryProxy) -> CGFloat {
    let offset = yOffset(proxy)
    return offset > 0 ? (startingHeight + offset) : startingHeight
  }
  
  private func stretchedOffset(_ proxy: GeometryProxy) -> CGFloat {
    let offset = yOffset(proxy)
    return offset > 0 ? -offset : 0
  }
}

public extension View {
  
  func stretchyHeader(height: CGFloat) -> some View {
    modifier(StetchyHeader(height: height))
  }
}
