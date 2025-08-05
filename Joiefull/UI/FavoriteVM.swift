//
//  FavoriteVM.swift
//  Joiefull
//
//  Created by Ordinateur elena on 05/08/2025.
//

import Foundation

class FavoriteViewModel: ObservableObject {
	//MARK: -Properties
	@Published var totalLikes: [Int: Int] = [:]
	@Published var userFavorites: Set<Int> = []
	
	//MARK: -Initialization
	init() {
		
	}
	
	//MARK: -Methods
	func toggleFavorite(for productId: Int) {
		if userFavorites.contains(productId) {
			userFavorites.remove(productId)
			totalLikes[productId, default: 1] -= 1
		} else {
			userFavorites.insert(productId)
			totalLikes[productId, default: 0] += 1
		}
	}
	
	func isFavorite(_ productId: Int) -> Bool {
		userFavorites.contains(productId)
	}
	
	func likesCount(for productId: Int) -> Int {
		totalLikes[productId] ?? 0
	}
	
	func setInitialLikes(for productId: Int, count: Int) {
		totalLikes[productId] = count
	}
	
	func userLikesCount() -> Int { 
		return userFavorites.count
	}
	
}
