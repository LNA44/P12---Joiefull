//
//  JoiefullRepositoryMock.swift
//  JoiefullTests
//
//  Created by Ordinateur elena on 12/08/2025.
//

//utile pour tests HomeViewModel
import XCTest
@testable import Joiefull

enum MockFetchProductsResult {
	case success(products: [Product])
	case error(Error)
}

final class JoiefullRepositoryMock: JoiefullRepositoryProtocol {
	
	var result: MockFetchProductsResult = .success(products: [])
	
	func fetchProducts() async throws -> [Product] {
		switch result {
		case .success(let products):
			return products
			
		case .error(let error):
			throw error
		}
	}
}
