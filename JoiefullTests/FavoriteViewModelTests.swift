//
//  JoiefullTests.swift
//  JoiefullTests
//
//  Created by Ordinateur elena on 05/08/2025.
//

import XCTest
@testable import Joiefull

final class FavoriteViewModelTests: XCTestCase {

	var favoriteVM: FavoriteViewModel!

	override func setUp() {
		super.setUp()
		favoriteVM = FavoriteViewModel()
	}

	override func tearDown() {
		favoriteVM = nil
		super.tearDown()
	}

	func testInitialLikesAreEmpty() {
		XCTAssertTrue(favoriteVM.totalLikes.isEmpty)
		XCTAssertTrue(favoriteVM.userFavorites.isEmpty)
	}

	func testSetInitialLikes() {
		favoriteVM.setInitialLikes(for: 1, count: 10)
		XCTAssertEqual(favoriteVM.likesCount(for: 1), 10)
	}

	func testToggleFavoriteAddsAndRemovesFavorite() {
		favoriteVM.setInitialLikes(for: 1, count: 5)

		XCTAssertFalse(favoriteVM.isFavorite(1))

		// Ajouter en favoris
		favoriteVM.toggleFavorite(for: 1)
		XCTAssertTrue(favoriteVM.isFavorite(1))
		XCTAssertEqual(favoriteVM.likesCount(for: 1), 6)  // +1 like

		// Retirer des favoris
		favoriteVM.toggleFavorite(for: 1)
		XCTAssertFalse(favoriteVM.isFavorite(1))
		XCTAssertEqual(favoriteVM.likesCount(for: 1), 5)  // -1 like
	}

	func testToggleFavoriteWithNoInitialLikes() {
		XCTAssertEqual(favoriteVM.likesCount(for: 2), 0)

		favoriteVM.toggleFavorite(for: 2)
		XCTAssertTrue(favoriteVM.isFavorite(2))
		XCTAssertEqual(favoriteVM.likesCount(for: 2), 1)

		favoriteVM.toggleFavorite(for: 2)
		XCTAssertFalse(favoriteVM.isFavorite(2))
		XCTAssertEqual(favoriteVM.likesCount(for: 2), 0)
	}
}
