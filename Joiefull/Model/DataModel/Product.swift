//
//  Product.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import Foundation

struct Product: Decodable, Identifiable, Equatable {
	var id: Int
	var picture: Picture
	var name: String
	
	var likes: Int
	var price: Double
	var originalPrice: Double
	var category: Category
	enum Category: String, Decodable {
		case accessories = "ACCESSORIES"
		case bottoms = "BOTTOMS"
		case shoes = "SHOES"
		case tops = "TOPS"
		
		var frenchName: String {
			switch self {
			case .accessories: return "Accessoires"
			case .bottoms:     return "Bas"
			case .shoes:       return "Chaussures"
			case .tops:        return "Hauts"
			}
		}
	}
	
	enum CodingKeys: String, CodingKey {
		case id, picture, name, likes, price, category
		case originalPrice = "original_price"  // originalPrice = original_price dans JSON
	}
	
	struct Picture: Decodable {
		var url: String
		var description: String
	}
}

extension Product.Picture {
	var imageURL: URL? {
		URL(string: url)
	}
}

extension Product { //permet de rendre Product conforme à Equatable pour comparer deux produits (utile dans CategoryRow pour vérifier si le produit a été sélectionné). Swift ne sait pas comparer les structure contenant des sous structures
	static func == (lhs: Product, rhs: Product) -> Bool { //on indique comment comparer deux Products (leftandSide et rightHandSide)
		return lhs.id == rhs.id &&
			   lhs.name == rhs.name &&
			   lhs.likes == rhs.likes &&
			   lhs.price == rhs.price &&
			   lhs.originalPrice == rhs.originalPrice &&
			   lhs.category == rhs.category &&
			   lhs.picture == rhs.picture
	}
}

extension Product.Picture: Equatable { //idem
	static func == (lhs: Product.Picture, rhs: Product.Picture) -> Bool {
		return lhs.url == rhs.url && lhs.description == rhs.description
	}
}
