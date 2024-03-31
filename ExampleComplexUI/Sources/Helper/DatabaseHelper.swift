//
//  DatabaseHelper.swift
//  ExampleComplexUI
//
//  Created by MAHESHWARAN on 28/03/24.
//

import Foundation

struct DatabaseHelper {
  
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

struct Product: Codable, Identifiable {
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
}
