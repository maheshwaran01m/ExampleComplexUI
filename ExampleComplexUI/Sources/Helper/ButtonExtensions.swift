//
//  ButtonExtensions.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 31/03/24.
//

import SwiftUI

struct ButtonTapStyle: ButtonStyle {
  
  private let style: Style
  
  init(_ style: Style = .tap) {
    self.style = style
  }
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? style.scale : 1)
      .opacity(configuration.isPressed ? style.opacity : 1)
      .brightness(configuration.isPressed ? style.brightness : 0)
  }
  
  
  enum Style {
    
    case custom(scale: CGFloat, opacity: Double, brightness: Double)
    
    static let press = Self.custom(scale: 0.95, opacity: 1, brightness: 0)
    
    static let opacity = Self.custom(scale: 1, opacity: 0.85, brightness: 0)
    
    static let tap = Self.custom(scale: 1, opacity: 1, brightness: 0)
    
    
    var scale: CGFloat {
      switch self {
      case .custom(let scale, _, _):
        return scale
      }
    }
    
    var opacity: Double {
      switch self {
      case .custom(_, let opacity, _):
        return opacity
      }
    }
    
    var brightness: Double {
      switch self {
      case .custom(_, _, let brightness):
        return brightness
      }
    }
  }
}

extension View {
  
  func button(_ style: ButtonTapStyle.Style = .tap,
              _ action: @escaping () -> Void) -> some View {
    
    Button(action: action) { self }
    .buttonStyle(ButtonTapStyle(style))
  }
  
  func link(_ style: ButtonTapStyle.Style = .tap, url: @escaping () -> URL) -> some View {
    
    Link(destination: url()) { self }
      .buttonStyle(ButtonTapStyle(style))
  }
}
