//
//  JoiefullRepositoryTests.swift
//  JoiefullTests
//
//  Created by Ordinateur elena on 12/08/2025.
//

import XCTest
@testable import Joiefull

final class JoiefullRepositoryTests: XCTestCase {

	let mockData = JoiefullRepositoryMock()
	
	lazy var session: URLSession = {
		let configuration = URLSessionConfiguration.ephemeral
		configuration.protocolClasses = [MockURLProtocol.self]
		return URLSession(configuration: configuration)
	}()
	
	lazy var apiService: JoiefullAPIService = {
		JoiefullAPIService(session: session)
	}()
	
	lazy var repository = JoiefullRepository(APIService: apiService)
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
		MockURLProtocol.requestHandler = nil
	}
	
	func test_FetchProducts_Success() async throws {
		//Given
		let (_,_,_) = mockData.makeMock(for: .success)
		
		//When & Then
		do {
			_ = try await repository.fetchProducts()
		} catch {
			XCTFail("Should not throw an error")
		}
	}
	
	func test_FetchProducts_EmptyData() async throws {
		//Given
		let (_,_,_) = mockData.makeMock(for: .emptyData)
		
		//When & Then
		do {
			_ = try await repository.fetchProducts()
			XCTFail("Expected to throw APIError.emptyData but did not throw")
		} catch APIError.emptyData {
			// Succès
		} catch {
			XCTFail("Unexpected error thrown: \(error)")
		}
	}
}

