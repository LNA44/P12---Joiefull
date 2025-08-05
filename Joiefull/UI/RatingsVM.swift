//
//  RatingsService.swift
//  Joiefull
//
//  Created by Ordinateur elena on 05/08/2025.
//

import Foundation

class RatingsViewModel: ObservableObject {
	//MARK: -Properties
	@Published var allRatings: [Int: [Double]]
	
	//MARK: -Initialization
	init() {
		self.allRatings = ratingsMock
	}
	
	func addRating(rating: Double, for productId: Int) {
		allRatings[productId, default: []].append(rating)
	}
	
	func getAverage(for productId: Int) -> Double {
			let ratings = allRatings[productId] ?? []
			guard !ratings.isEmpty else { return 0.0 }
			let total = ratings.reduce(0, +) //somme des notes
			return total / Double(ratings.count)
	}
}
