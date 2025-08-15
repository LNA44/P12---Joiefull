//
//  HomeViewModelTests.swift
//  JoiefullTests
//
//  Created by Ordinateur elena on 12/08/2025.
//

import XCTest
@testable import Joiefull

final class HomeViewModelTests: XCTestCase {
	
	var viewModel: HomeViewModel!
	var mockRepository: JoiefullRepositoryMock!
	
	override func setUp() {
		super.setUp()
		mockRepository = JoiefullRepositoryMock()
		viewModel = HomeViewModel(repository: mockRepository)
	}
	
	override func tearDown() {
		viewModel = nil
		mockRepository = nil
		super.tearDown()
	}
	
	func testFetchProductsSuccess() async {
		// Given
		let mockProducts = [
			Product(
				id: 1,
				picture: Product.Picture(url: "https://example.com/img.jpg", description: "Image description"),
				name: "Produit 1",
				likes: 10,
				price: 9.99,
				originalPrice: 12.99,
				category: .accessories
			)
		]
		mockRepository.result = .success(products: mockProducts)
		
		// When
		await viewModel.fetchProducts()
		
		// Then
		XCTAssertEqual(viewModel.products.count, mockProducts.count)
		XCTAssertEqual(viewModel.products.first?.name, "Produit 1")
		XCTAssertNil(viewModel.errorMessage)
		XCTAssertFalse(viewModel.showAlert)
	}
	
	func testCategoriesGrouping() async {
		// Given
		let products = [
			Product(
				id: 1,
				picture: Product.Picture(url: "url1", description: "desc1"),
				name: "Produit 1",
				likes: 5,
				price: 10,
				originalPrice: 12,
				category: .accessories
			),
			Product(
				id: 2,
				picture: Product.Picture(url: "url2", description: "desc2"),
				name: "Produit 2",
				likes: 7,
				price: 15,
				originalPrice: 20,
				category: .bottoms
			),
			Product(
				id: 3,
				picture: Product.Picture(url: "url3", description: "desc3"),
				name: "Produit 3",
				likes: 3,
				price: 8,
				originalPrice: 9,
				category: .accessories
			)
		]
		viewModel.products = products
		
		// When
		let grouped = viewModel.categories
		
		// Then
		XCTAssertEqual(grouped.count, 2)
		XCTAssertEqual(grouped["Accessoires"]?.count, 2)
		XCTAssertEqual(grouped["Bas"]?.count, 1)
	}
	
	func testFetchProducts_ErrorSetsErrorMessageAndShowAlert() async {
		// Given
		mockRepository.result = .error(NSError(domain: "", code: 0, userInfo: nil))
		
		let viewModel = HomeViewModel(repository: mockRepository)
		
		// When
		await viewModel.fetchProducts()
		
		// Then
		XCTAssertNotNil(viewModel.errorMessage)
		XCTAssertTrue(viewModel.showAlert)
		XCTAssertTrue(viewModel.products.isEmpty)
	}
	
}
