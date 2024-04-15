//
//  ScrollViewWithOnScroll.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 14/04/24.
//

import SwiftUI

public struct ScrollViewWithOnScroll<Content:View>: View {
  
  let axes: Axis.Set
  let showsIndicators: Bool
  let content: Content
  let onScrollChanged: (_ origin: CGPoint) -> ()
  @State private var coordinateSpaceID: String = UUID().uuidString
  
  public init(
    _ axes: Axis.Set = .vertical,
    showsIndicators: Bool = false,
    @ViewBuilder content: () -> Content,
    onScrollChanged: @escaping (_ origin: CGPoint) -> ()) {
      self.axes = axes
      self.showsIndicators = showsIndicators
      self.content = content()
      self.onScrollChanged = onScrollChanged
    }
  
  public var body: some View {
    ScrollView(axes, showsIndicators: showsIndicators) {
      LocationReader(coordinateSpace: .named(coordinateSpaceID), onChange: onScrollChanged)
      content
    }
    .coordinateSpace(name: coordinateSpaceID)
  }
}

fileprivate struct LocationReader: View {
  
  let coordinateSpace: CoordinateSpace
  let onChange: (_ location: CGPoint) -> Void
  
  public init(coordinateSpace: CoordinateSpace, onChange: @escaping (_ location: CGPoint) -> Void) {
    self.coordinateSpace = coordinateSpace
    self.onChange = onChange
  }
  
  public var body: some View {
    FrameReader(coordinateSpace: coordinateSpace) { frame in
      onChange(CGPoint(x: frame.midX, y: frame.midY))
    }
    .frame(width: 0, height: 0, alignment: .center)
  }
}

fileprivate struct FrameReader: View {
  
  let coordinateSpace: CoordinateSpace
  let onChange: (_ frame: CGRect) -> Void
  
  public init(coordinateSpace: CoordinateSpace,
              onChange: @escaping (_ frame: CGRect) -> Void) {
    
    self.coordinateSpace = coordinateSpace
    self.onChange = onChange
  }
  
  public var body: some View {
    GeometryReader { geo in
      Color.clear
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
          onChange(geo.frame(in: coordinateSpace))
        }
        .onChange(of: geo.frame(in: coordinateSpace), perform: onChange)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
