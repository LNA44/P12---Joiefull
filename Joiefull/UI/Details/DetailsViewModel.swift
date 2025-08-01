//
//  DetailsViewModel.swift
//  Joiefull
//
//  Created by Ordinateur elena on 01/08/2025.
//

import Foundation

class DetailsViewModel: ObservableObject {
	@Published private var ratings: [Int: [Int]] = [:]
	@Published private var userProductFavorites: Int = 14
	
	init() { //fauses notes utilisées car pas de note moyenne renvoyée par l'API
			ratings[0] = [1, 2, 3, 4]
			ratings[1] = [4, 5, 3]
			ratings[2] = [2, 3]
			ratings[3] = [5]
			ratings[4] = [1]
			ratings[5] = [4, 4, 5]
			ratings[6] = [3, 2]
			ratings[7] = [5, 5]
			ratings[8] = [1, 2, 3]
			ratings[9] = [4]
			ratings[10] = [5, 5, 5, 5]
			ratings[11] = [2, 3, 4]
			ratings[12] = [5]
		}
	
	func addRating(productId: Int, rating: Int) {
		var currentRatings = ratings[productId, default: []]
		currentRatings.append(rating)
		ratings[productId] = currentRatings
	}
	
	func averageRating(productId: Int) -> Double {
		let productRatings = ratings[productId, default: []]
		print("tableau du produit \(productRatings)")
		guard !productRatings.isEmpty else { return 0.0 }
		return Double(productRatings.reduce(0, +)) / Double(productRatings.count)
	}
	
	func addToFavorite(productId: Int) {
		
	}

}
