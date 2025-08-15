//
//  RatingsViewModelTests.swift
//  JoiefullTests
//
//  Created by Ordinateur elena on 05/08/2025.
//

import XCTest
@testable import Joiefull

final class RatingsViewModelTests: XCTestCase {
	
	var ratingsVM: RatingsViewModel!
	
	override func setUp() {
		super.setUp()
		ratingsVM = RatingsViewModel()
	}
	
	override func tearDown() {
		ratingsVM = nil
		super.tearDown()
	}
	
	func test_addOneRating_increasesCountAndAffectsAverage() {
		// Given
		let productId = 1
		
		// When
		ratingsVM.addRating(rating: 5.0, for: productId)
		
		// Then
		let ratings = ratingsVM.allRatings[productId]
		XCTAssertEqual(ratings?.count, 4) //3 factices + 1 du test
		XCTAssertEqual(ratingsVM.getAverage(for: productId), 4.25)
		XCTAssertEqual(ratingsVM.userRatings[productId], 5.0)
	}
	
	func test_addSeveralRatings_increasesAverage() {
		// Given
		let productId = 1
		
		// When
		ratingsVM.addRating(rating: 5.0, for: productId)
		ratingsVM.addRating(rating: 3.0, for: productId)
		
		// Then
		let ratings = ratingsVM.allRatings[productId]
		XCTAssertEqual(ratings?.count, 4) //3 factices + 1 du test
		let userRatings = ratingsVM.userRatings[productId]
		XCTAssertEqual(userRatings, 3.0)
		XCTAssertEqual(ratingsVM.getAverage(for: productId), 3.75)
	}
	
	func test_addRating_toNewProduct_createsEntry() {
		// Given
		let newProductId = 999 // aucun rating factice pour celui-ci
		
		// When
		ratingsVM.addRating(rating: 4.0, for: newProductId)
		
		// Then
		XCTAssertEqual(ratingsVM.allRatings[newProductId]?.count, 1)
		XCTAssertEqual(ratingsVM.allRatings[newProductId]?.first, 4.0)
		XCTAssertEqual(ratingsVM.userRatings[newProductId], 4.0)
	}
	
	func test_getAverage_whenNoRatings_returnsZero() {
		// Given
		let productId = 999
		
		// When
		let average = ratingsVM.getAverage(for: productId)
		
		// Then
		XCTAssertEqual(average, 0.0)
	}
	
	func test_getUserRating_whenUserHasVoted_returnsRating() {
		// Given
		let productId = 1
		ratingsVM.addRating(rating: 4.0, for: productId)
		
		// When
		let rating = ratingsVM.getUserRating(for: productId)
		
		// Then
		XCTAssertEqual(rating, 4.0)
	}

	func test_getUserRating_whenUserHasNotVoted_returnsZero() {
		// Given
		let productId = 999 // aucun vote factice pour ce produit
		
		// When
		let rating = ratingsVM.getUserRating(for: productId)
		
		// Then
		XCTAssertEqual(rating, 0.0)
	}
}
