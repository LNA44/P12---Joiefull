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
	
	func test_addRating_increasesCountAndAffectsAverage() {
		// Given
		let productId = 1
		
		// When
		ratingsVM.addRating(rating: 5.0, for: productId)
		ratingsVM.addRating(rating: 3.0, for: productId)
		
		// Then
		let ratings = ratingsVM.allRatings[productId]
		XCTAssertEqual(ratings?.count, 5) //3 factices + 2 du test
		XCTAssertEqual(ratingsVM.getAverage(for: productId), 4.0, accuracy: 0.001)
	}
	
	func test_getAverage_whenNoRatings_returnsZero() {
		// Given
		let productId = 999
		
		// When
		let average = ratingsVM.getAverage(for: productId)
		
		// Then
		XCTAssertEqual(average, 0.0)
	}
}
