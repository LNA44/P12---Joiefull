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
}
