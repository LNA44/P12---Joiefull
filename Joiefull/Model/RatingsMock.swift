//
//  RatingsMock.swift
//  Joiefull
//
//  Created by Ordinateur elena on 05/08/2025.
//

import Foundation

struct RatingsMock {
	enum Product: Int, CaseIterable {
		case product0 = 0
		case product1 = 1
		case product2 = 2
		case product3 = 3
		case product4 = 4
		case product5 = 5
		case product6 = 6
		case product7 = 7
		case product8 = 8
		case product9 = 9
		case product10 = 10
		case product11 = 11
		case product12 = 12
	}

	static let data: [Product: [Double]] = [
		.product0: [4, 2, 5],
		.product1: [3, 4, 5],
		.product2: [4, 5, 4],
		.product3: [2, 3, 4],
		.product4: [5, 5, 5],
		.product5: [1, 2, 3],
		.product6: [4, 4, 4],
		.product7: [5, 5, 5],
		.product8: [2, 3, 4],
		.product9: [4, 5, 4],
		.product10: [5, 5, 5],
		.product11: [1, 2, 3],
		.product12: [4, 4, 4]
	]
}
