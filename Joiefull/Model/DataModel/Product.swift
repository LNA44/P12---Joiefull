//
//  Product.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import Foundation

struct Product: Decodable, Identifiable {
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
		case originalPrice = "original_price"  // on indique que originalPrice = original_price dans JSON
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
