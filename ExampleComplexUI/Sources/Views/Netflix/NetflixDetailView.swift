//
//  NetflixDetailView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 14/04/24.
//

import SwiftUI

struct NetflixDetailView: View {
  
  @SwiftUI.Environment(\.dismiss) private var dismiss

  var product: Product = .preview
  @State private var progress: Double = 0.2
  
  @State private var isMyList = false

  @State private var products = [Product]()
  
  var body: some View {
    ZStack {
      Color.netflixBlack.ignoresSafeArea()
      Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
      
      mainView
    }
    .task { await getData() }
    .toolbar(.hidden, for: .navigationBar)
  }
  
  private var mainView: some View {
    VStack(spacing: .zero) {
      headerView
      scrollView
    }
  }
  
  private var headerView: some View {
    NetflixDetailHeaderView(imageName: product.firstImage, progress: progress)
      .onAirPlayClicked {
        
      }
      .close {
        dismiss()
      }
  }
  
  private var scrollView: some View {
    ScrollView {
      
      VStack(alignment: .leading, spacing: 16) {
        NetflixDetailProductView(title: product.title)
        
        iconButtonView
        gridView
      }
      .padding(8)
    }
    .scrollIndicators(.hidden)
  }
  
  private var iconButtonView: some View {
    HStack(spacing: 8) {
      NetflixListButtonView(isMyList: isMyList) {
        isMyList.toggle()
      }
      
      NetflixRateButtonView()
      
      NetflixShareButtonView()
    }
  }
  
  private var gridView: some View {
    VStack(alignment: .leading) {
      Text("More Like This")
        .font(.headline)
      
      LazyVGrid(
        columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3),
        spacing: 8) {
          
          ForEach(products) { product in
            NetflixMovieView(
              imageName: product.firstImage,
              title: product.title)
          }
        }
    }
    .foregroundStyle(.netflixWhite)
  }
}

// MARK: - Get Data

extension NetflixDetailView {
  
  private func getData() async {
    guard products.isEmpty else { return }
    do {
      products = try await DatabaseHelper().getProducts().shuffled()
    } catch {
      print("Error \(error.localizedDescription)")
    }
  }
}

// MARK: - Preview

struct NetflixDetailView_Previews: PreviewProvider {
  
  static var previews: some View {
    NetflixDetailView()
  }
}
