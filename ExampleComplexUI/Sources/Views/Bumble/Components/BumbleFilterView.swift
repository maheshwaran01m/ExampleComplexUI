//
//  BumbleFilterView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 06/04/24.
//

import SwiftUI

struct BumbleFilterView: View {
  
  let options: [String]
  
  @Binding var selection: String
  @Namespace private var namespace
  
  init(_ options: [String],
       selection: Binding<String>) {
    self.options = options
    _selection = selection
    checkOptionsAreMatching()
  }
  
  var body: some View {
    HStack(alignment: .top, spacing: 30) {
      ForEach(options, id: \.self) { option in
        mainView(option)
      }
    }
    .animation(.smooth, value: selection)
  }
  
  private func mainView(_ option: String) -> some View {
    VStack {
      Text(option)
        .frame(maxWidth: .infinity)
        .font(.subheadline)
        .fontWeight(.medium)
      
      if selection == option {
        RoundedRectangle(cornerRadius: 2)
          .frame(height: 1.5)
          .matchedGeometryEffect(id: "selection", in: namespace)
      }
    }
    .padding(.top, 8)
    .background(Color.bumbleBlack.opacity(0.01))
    .foregroundStyle(selection == option ? .bumbleBlack : .bumbleGray)
    .onTapGesture {
      selection = option
    }
  }
  
  private func checkOptionsAreMatching() {
    if !options.contains(selection) {
      assertionFailure("Selected option not matching with the options")
    }
  }
}

// MARK: - Preview

struct BumbleFilterView_Previews: PreviewProvider {
  
  static var previews: some View {
    PreviewView()
  }
  
  struct PreviewView: View {
    
    @State private var selection: String = "Everyone"
    
    var body: some View {
      BumbleFilterView(["Everyone", "Trending"],
                       selection: $selection)
    }
  }
}
