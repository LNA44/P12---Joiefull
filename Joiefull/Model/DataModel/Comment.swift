//
//  Comment.swift
//  Joiefull
//
//  Created by Ordinateur elena on 13/08/2025.
//

import Foundation

struct Comment: Identifiable {
	let id = UUID()
	let author: String
	let text: String
	let date: Date
}
