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
	
	func test_toggleFavorite_addsFavoriteAndIncrementsLikes() {
		let productId = 1
		favoriteVM.setInitialLikes(for: productId, count: 5)
		
		favoriteVM.toggleFavorite(for: productId)
		
		XCTAssertTrue(favoriteVM.userFavorites.contains(productId))
		XCTAssertEqual(favoriteVM.likesCount(for: productId), 6)
	}
	
	func test_toggleFavorite_removesFavoriteAndDecrementsLikes() {
		let productId = 2
		favoriteVM.setInitialLikes(for: productId, count: 3)
		favoriteVM.userFavorites.insert(productId)
		
		favoriteVM.toggleFavorite(for: productId)
		
		XCTAssertFalse(favoriteVM.userFavorites.contains(productId))
		XCTAssertEqual(favoriteVM.likesCount(for: productId), 2)
	}
	
	func test_toggleFavorite_likesNeverNegative() {
		let productId = 3
		
		// totalLikes n'est pas initialisé, donc vaut nil au départ
		// On insère le favori pour incrémenter une fois
		favoriteVM.toggleFavorite(for: productId)
		XCTAssertEqual(favoriteVM.likesCount(for: productId), 1)
		
		// Maintenant on retire le favori
		favoriteVM.toggleFavorite(for: productId)
		XCTAssertEqual(favoriteVM.likesCount(for: productId), 0)
		
		// Si on retire encore (pas dans userFavorites), likes doit rester à 0
		favoriteVM.toggleFavorite(for: productId) // Ajoute de nouveau
		favoriteVM.toggleFavorite(for: productId) // Retire
		favoriteVM.toggleFavorite(for: productId) // Ajoute
		favoriteVM.toggleFavorite(for: productId) // Retire
		
		XCTAssertGreaterThanOrEqual(favoriteVM.likesCount(for: productId), 0)
	}
	
	func test_toggleFavorite_handlesNegativeLikes() {
		let productId = 42
		
		// Forcer un état incohérent : totalLikes négatif
		favoriteVM.totalLikes[productId] = -3
		favoriteVM.userFavorites.insert(productId) 
		
		// Appeler toggleFavorite (doit retirer le favori et ne pas descendre en dessous de 0)
		favoriteVM.toggleFavorite(for: productId)
		
		// Vérifier que totalLikes ne devient pas négatif
		XCTAssertGreaterThanOrEqual(favoriteVM.likesCount(for: productId), 0)
		XCTAssertEqual(favoriteVM.likesCount(for: productId), 0)
	}
	
	func test_userLikesCount_returnsCorrectNumber() {
		// Quand aucun favori
		XCTAssertEqual(favoriteVM.userLikesCount(), 0)
		
		// Ajout de favoris
		favoriteVM.userFavorites.insert(1)
		favoriteVM.userFavorites.insert(2)
		favoriteVM.userFavorites.insert(3)
		
		// Then
		XCTAssertEqual(favoriteVM.userLikesCount(), 3)
		
		// Suppression d'un favori
		favoriteVM.userFavorites.remove(2)
		
		// Then
		XCTAssertEqual(favoriteVM.userLikesCount(), 2)
	}
	
	func test_likesCount_returnsZeroIfNoLikesForProduct() {
		let productId = 999
		
		XCTAssertEqual(favoriteVM.likesCount(for: productId), 0)
	}
	
	func test_isFavorite_returnsTrueWhenFavoritedAndFalseOtherwise() {
		let productId = 10
		
		// Au départ, le produit n'est pas favori
		XCTAssertFalse(favoriteVM.isFavorite(productId))
		
		// On ajoute le produit aux favoris
		favoriteVM.userFavorites.insert(productId)
		
		// Maintenant la fonction doit retourner true
		XCTAssertTrue(favoriteVM.isFavorite(productId))
		
		// On retire le produit des favoris
		favoriteVM.userFavorites.remove(productId)
		
		// Et à nouveau, c'est false
		XCTAssertFalse(favoriteVM.isFavorite(productId))
	}
}
