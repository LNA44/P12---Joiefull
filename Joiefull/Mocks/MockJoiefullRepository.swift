//
//  MockRepository.swift
//  Joiefull
//
//  Created by Ordinateur elena on 11/08/2025.
//

import Foundation

class MockJoiefullRepository: JoiefullRepositoryProtocol {
	func fetchProducts() async throws -> [Product] {
		// Retourne un tableau de produits factices pour previews
		return [
			Product(id: 1,
					picture: Product.Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/1.jpg", description: "Image 1"),
					name: "Produit Mock 1",
					likes: 12,
					price: 29.99,
					originalPrice: 39.99,
					category: .tops),
			Product(id: 2,
					picture: Product.Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/1.jpg", description: "Image 2"),
					name: "Produit Mock 2",
					likes: 7,
					price: 59.99,
					originalPrice: 79.99,
					category: .shoes)
		]
	}
}
