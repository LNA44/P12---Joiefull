//
//  HomeViewVM.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
	//MARK: -Public properties
	@Published var errorMessage: String?
	@Published var showAlert: Bool = false
	@Published var products: [Product] = []
	var categories: [String: [Product]] {
		Dictionary(grouping: products,
				   by: { $0.category.frenchName }
		)
	}
	
	//MARK: -Private properties
	private let repository: JoiefullRepositoryProtocol
	
	//MARK: -Initialization
	init(repository: JoiefullRepositoryProtocol) {
		self.repository = repository
	}
	
	//MARK: -Methods
	@MainActor
	func fetchProducts() async {
		do {
			let products = try await repository.fetchProducts()
			self.products = products
		} catch {
			errorMessage = "Unknown error happened : \(error.localizedDescription)"
			showAlert = true
		}
	}
}
