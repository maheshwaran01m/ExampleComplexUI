//
//  DatabaseHelper.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 28/03/24.
//

import Foundation

struct DatabaseHelper {
  
  static let imageURL =  "https://picsum.photos/600/600"
  
  func getProducts() async throws -> [Product] {
    guard let url = URL(string: "https://dummyjson.com/products") else {
      throw URLError(.badURL)
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let result = try JSONDecoder().decode(Products.self, from: data)
    
    return result.products
  }
  
  func getUsers() async throws -> [User] {
    guard let url = URL(string: "https://dummyjson.com/users") else {
      throw URLError(.badURL)
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let result = try JSONDecoder().decode(Users.self, from: data)
    
    return result.users
  }
}

// MARK: - Data Model

struct Products: Codable {
  let products: [Product]
}

struct Product: Codable, Identifiable, Hashable {
  let id: Int
  let title, description: String
  let price: Int
  let discountPercentage, rating: Double
  let stock: Int
  let brand, category: String
  let thumbnail: String
  let images: [String]
  
  var firstImage: String {
    images.first ?? ""
  }
  
  static var preview: Product {
    .init(id: 0, title: "Example Product",
          description: "Description", price: 999,
          discountPercentage: 15,
          rating: 4, stock: 50,
          brand: "Apple", category: "Electronic Devices",
          thumbnail: DatabaseHelper.imageURL,
          images: [DatabaseHelper.imageURL, DatabaseHelper.imageURL, DatabaseHelper.imageURL])
  }
}

struct ProductCategory: Identifiable {
  let id = UUID().uuidString
  let title: String
  let products: [Product]
}

// MARK: User

struct Users: Codable {
  let users: [User]
}

struct User: Codable {
  let id: Int
  let firstName, lastName: String
  let age: Int
  let email, phone, username, password: String
  let image: String
  let height: Int
  let weight: Double
  
  var work: String { "Software Engineer" }
  var education: String { "Master of Science" }
  var aboutMe: String { "Example for about Me" }
  
  var basic: [BumbleInterestView.Item] {
    [.init(iconName: "ruler", text: height.description),
     .init(iconName: "graduationcap", text: education),
      .init(iconName: "wineglass", text: "Socially"),
     .init(iconName: "moon.stars.fill", text: "Text")
    ]
  }
  
  var interests: [BumbleInterestView.Item] {
    [.init(emoji: "🏃‍♂️", text: "Running"),
     .init(emoji: "👨‍💻", text: "Coding"),
     .init(emoji: "🎧", text: "Music")
    ]
  }
  
  var images: [String] {
    ["https://picsum.photos/600/600",
     "https://picsum.photos/500/500",
     "https://picsum.photos/700/700"]
  }
  
  static var preview: User {
    .init(id: 0,
          firstName: "First",
          lastName: "Last Name", age: 0, email: "example",
          phone: "", username: "User", password: "",
          image: DatabaseHelper.imageURL,
          height: 0, weight: 0
    )
  }
}
