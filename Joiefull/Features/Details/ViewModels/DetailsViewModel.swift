//
//  DetailsViewModel.swift
//  Joiefull
//
//  Created by Ordinateur elena on 01/08/2025.
//

import Foundation

class DetailsViewModel: ObservableObject {
	//MARK: -Private properties
	@Published private var ratings: [Int: [Int]] = [:]
	@Published private var userProductFavorites: Int = 14
	@Published var commentsByProduct: [Int: [Comment]] = [:]
	
	//MARK: -Methods
	func addComment(for productID: Int, author: String, text: String) {
		let newComment = Comment(author: author, text: text, date: Date())
		if commentsByProduct[productID] != nil {
			commentsByProduct[productID]?.append(newComment)
		} else {
			commentsByProduct[productID] = [newComment]
		}
	}
}
