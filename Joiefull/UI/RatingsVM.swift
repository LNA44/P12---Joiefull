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
	@Published var userRatings: [Int: Double] = [:] //note utilisateur par produit
	
	//MARK: -Initialization
	init() {
		self.allRatings = ratingsMock
	}
	
	func addRating(rating: Double, for productId: Int) {
		if userRatings[productId] == nil { //empecher l'utilisateur de revoter
			allRatings[productId, default: []].append(rating) //ajout note au tableau du produit
		}
		userRatings[productId] = rating //ajout de la note au tableau des notes de l'utilisateur
	}
	
	func getAverage(for productId: Int) -> Double {
			let ratings = allRatings[productId] ?? []
			guard !ratings.isEmpty else { return 0.0 }
			let total = ratings.reduce(0, +) //somme des notes
			return total / Double(ratings.count)
	}
	
	func getUserRating(for productId: Int) -> Double { //utile pour qu'à l'ouverture d'un produit on retrouve la note donnée par l'utilisateur avec le nombre d'étoiles sélectionnées
		return userRatings[productId] ?? 0.0
	}
}
