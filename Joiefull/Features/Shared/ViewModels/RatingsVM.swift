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
			// L'utilisateur a déjà voté: remplacer sa note dans allRatings
			if let index = allRatings[productId]?.firstIndex(of: oldRating) {
				allRatings[productId]?[index] = rating
			}
		} else {
			// Premier vote: ajouter la note
			allRatings[productId, default: []].append(rating) 
		}
		
		// Mettre à jour (ou enregistrer) le vote de l'utilisateur
		userRatings[productId] = rating
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
