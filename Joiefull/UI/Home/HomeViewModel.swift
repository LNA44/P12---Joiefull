//
//  HomeViewVM.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
	//MARK: -Public properties
	private let repository: JoiefullRepository
	@Published var products: [Product] = []
	var categories: [String: [Product]] {
		Dictionary(grouping: products,
				   by: { $0.category.frenchName }
		)
	}
	
	//MARK: -Initialization
	init(repository: JoiefullRepository) {
		self.repository = repository
	}
	
	//MARK: -Methods
	@MainActor
	func fetchProducts() async {
		do {
			let products = try await repository.fetchProducts()
			self.products = products
		} catch {
			print ("erreur chargement produits VM", error.localizedDescription)
		}
	}
}
