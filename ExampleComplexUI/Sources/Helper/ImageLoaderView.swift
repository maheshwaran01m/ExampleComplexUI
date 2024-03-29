//
//  ImageLoaderView.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 28/03/24.
//

import SwiftUI

struct ImageLoaderView: View {
  
  @StateObject private var viewModel: ImageCacheViewModel
  
  init(_ url: String = "https://picsum.photos/600/600",
       contentMode type: ContentMode = .fill) {
    _viewModel = .init(wrappedValue: .init())
  }
  
  var body: some View {
    Rectangle()
      .opacity(0.001)
      .background(content: imageView)
      .clipped()
  }
  
  @ViewBuilder
  private func imageView() -> some View {
    switch viewModel.imageState {
    case .loading:
      ProgressView()
      
    case .sucess(let image):
      image
        .resizable()
        .aspectRatio(contentMode: viewModel.contentMode)
        .allowsTightening(false)
      
    case .empty, .failed: EmptyView()
    }
  }
}

// MARK: - Preview

struct ImageLoaderView_Previews: PreviewProvider {
  
  static var previews: some View {
    ImageLoaderView()
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .padding(40)
      .padding(.vertical, 60)
  }
}

private class ImageCacheViewModel: ObservableObject {
  
  enum ImageState {
    case empty, loading, sucess(Image), failed(Error)
  }
  
  @Published var imageState = ImageState.empty
  
  let urlString: String
  let contentMode: ContentMode
  
  init(_ url: String = "https://picsum.photos/600/600",
       contentMode type: ContentMode = .fill) {
    urlString = url
    contentMode = type
    setupImage()
  }
  
  private func setupImage() {
    imageState = .loading
    
    CacheManager.shared.downloadImage(urlString) { image in
      
      switch image {
      case .success(let uiImage):
        DispatchQueue.main.async { [weak self] in
          self?.imageState = .sucess(.init(uiImage: uiImage))
        }
        
      case .failure(let error):
        debugPrint("Error while downloading image")
        DispatchQueue.main.async { [weak self] in
          self?.imageState = .failed(error)
        }
      }
    }
  }
}

// MARK: - CacheManager

public final class CacheManager {
  
  public static let shared = CacheManager()
    
  private let imageCache = NSCache<NSString, UIImage>()
  
  public func downloadImage(_ urlString: String, 
                            completion: @escaping (Result<UIImage, Error>) -> Void) {
    
    let cacheKey = NSString(string: urlString)
    
    if let image = imageCache.object(forKey: cacheKey) {
      completion(.success(image))
    } else {
      
      guard let url = URL(string: urlString) else { return }
      
      URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
        
        let result: Result<UIImage, Error>
        
        defer { completion(result) }
        
        guard let self, error == nil else {
          result = .failure(URLError(.badServerResponse))
          return
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
          result = .failure(URLError(.badServerResponse))
          return
        }
        guard let data, let image = UIImage(data: data) else {
          result = .failure(URLError(.dataNotAllowed))
          return
        }
        // cache image
        imageCache.setObject(image, forKey: cacheKey)
        
        result = .success(image)
      }.resume()
    }
  }
}

// MARK: - Get

public extension CacheManager {
  
  func getValue(_ key: String) -> UIImage? {
    guard let image = imageCache.object(forKey: cacheKey(key)) else { return nil }
    return image
  }
  
  func contains(_ key: String) -> Bool {
    return getValue(key) != nil
  }
  
  private func cacheKey(_ key: String) -> NSString {
    NSString(string: key)
  }
}

// MARK: - Clear Cache

public extension CacheManager {
  
  func clearImageCache() {
    imageCache.removeAllObjects()
  }
  
  func clearImageCache(forKey key: String) {
    imageCache.removeObject(forKey: cacheKey(key))
  }
}
