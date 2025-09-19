//
//  RatingsService.swift
//  Joiefull
//
//  Created by Ordinateur elena on 05/08/2025.
//

import Foundation

class RatingsViewModel: ObservableObject {
	//MARK: -Public roperties
	@Published var allRatings: [Int: [Double]]
	@Published var userRatings: [Int: Double] = [:] //note utilisateur par produit
	
	//MARK: -Initialization
	init() {
		self.allRatings = RatingsMock.data.reduce(into: [:]) { result, pair in //permet d'avoir [Int: [Double]] au lieu de [Product: [Double]]
			result[pair.key.rawValue] = pair.value
		}
	}
	
	//MARK: -Methods
	func addRating(rating: Double, for productId: Int) {
		if let oldRating = userRatings[productId] {
			if let index = allRatings[productId]?.firstIndex(of: oldRating) {
				allRatings[productId]?[index] = rating
			}
		} else {
			allRatings[productId, default: []].append(rating)
		}
		userRatings[productId] = rating
	}
	
	func getAverage(for productId: Int) -> Double {
		let ratings = allRatings[productId] ?? []
		guard !ratings.isEmpty else { return 0.0 }
		let total = ratings.reduce(0, +) //somme des notes
		return total / Double(ratings.count)
	}
	
	func getUserRating(for productId: Int) -> Double { 
		return userRatings[productId] ?? 0.0
	}
}
