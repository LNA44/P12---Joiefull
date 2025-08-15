//
//  DetailsViewModelTests.swift
//  JoiefullTests
//
//  Created by Ordinateur elena on 13/08/2025.
//

import XCTest
@testable import Joiefull

final class DetailsViewModelTests: XCTestCase {

	var viewModel: DetailsViewModel!

		override func setUp() {
			super.setUp()
			viewModel = DetailsViewModel()
		}

		override func tearDown() {
			viewModel = nil
			super.tearDown()
		}
	
	func testAddComment_NewProduct_CreatesArray() {
			// Given
			let productID = 1
			XCTAssertNil(viewModel.commentsByProduct[productID])

			// When
			viewModel.addComment(for: productID, author: "Alice", text: "Super produit !")

			// Then
			let comments = viewModel.commentsByProduct[productID]
			XCTAssertNotNil(comments)
			XCTAssertEqual(comments?.count, 1)
			XCTAssertEqual(comments?.first?.author, "Alice")
			XCTAssertEqual(comments?.first?.text, "Super produit !")
		}

	func testAddComment_ExistingProduct_AppendsComment() {
			// Given
			let productID = 2
			viewModel.addComment(for: productID, author: "Bob", text: "Premier commentaire")

			// When
			viewModel.addComment(for: productID, author: "Charlie", text: "Deuxième commentaire")

			// Then
			let comments = viewModel.commentsByProduct[productID]
			XCTAssertEqual(comments?.count, 2)
			XCTAssertEqual(comments?[0].author, "Bob")
			XCTAssertEqual(comments?[1].author, "Charlie")
		}

}
