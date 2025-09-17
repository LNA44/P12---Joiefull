//
//  FavoriteVM.swift
//  Joiefull
//
//  Created by Ordinateur elena on 05/08/2025.
//

import Foundation

class FavoriteViewModel: ObservableObject {
	//MARK: -Public properties
	@Published var totalLikes: [Int: Int] = [:]
	@Published var userFavorites: Set<Int> = []
	
	//MARK: -Methods
	func toggleFavorite(for productId: Int) {
		if userFavorites.contains(productId) {
			userFavorites.remove(productId)
			
			// Décrémenter seulement si la valeur est > 0
			if let currentLikes = totalLikes[productId], currentLikes > 0 {
				totalLikes[productId] = currentLikes - 1
			} else {
				totalLikes[productId] = 0
			}
			
		} else {
			userFavorites.insert(productId)
			totalLikes[productId, default: 0] += 1 //default : si la clé liée au product n'existe pas encore alors 0, pas nil (car dico renvoie tjrs nil si clé n'existe pas sinon)
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
