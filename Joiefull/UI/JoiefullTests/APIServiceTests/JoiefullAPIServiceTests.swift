//
//  JoiefullAPIServiceTests.swift
//  JoiefullTests
//
//  Created by Ordinateur elena on 12/08/2025.
//

import XCTest
@testable import Joiefull

final class JoiefullAPIServiceTests: XCTestCase {

	let mockData = JoiefullAPIServiceMock()
	
	lazy var session: URLSession = {
		let configuration = URLSessionConfiguration.ephemeral
		configuration.protocolClasses = [MockURLProtocol.self]
		return URLSession(configuration: configuration)
	}()
	
	lazy var apiService: JoiefullAPIService = {
		JoiefullAPIService(session: session)
	}()
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
		MockURLProtocol.requestHandler = nil
	}
	
	func test_CreateEndpoint_WithValidURL_ReturnsURL() throws {
		// Prépare la constante avec une URL valide
		Constants.baseURL = "https://example.com"
		
		let apiService = JoiefullAPIService() // ou ton objet qui contient createEndpoint()
		
		do {
			let url = try apiService.createEndpoint()
			XCTAssertEqual(url.absoluteString, "https://example.com")
		} catch {
			XCTFail("Did not expect an error but got: \(error)")
		}
	}

	func test_CreateEndpoint_WithInvalidURL_ThrowsInvalidURL() throws {
		// Prépare la constante avec une URL invalide
		Constants.baseURL = ""
		
		let apiService = JoiefullAPIService()
		
		XCTAssertThrowsError(try apiService.createEndpoint()) { error in
			XCTAssertEqual(error as? APIError, APIError.invalidURL)
		}
	}
	
	func testCreateRequestySucess() {
		//Given
		let endpoint: URL = URL(string: "https://example.com")!
		//When
		let request = apiService.createRequest(endpoint: endpoint)
		//Then
		XCTAssertEqual(request.httpMethod, Constants.method)
		XCTAssertEqual(request.url, endpoint)
		XCTAssertNil(request.httpBody)
		XCTAssertNil(request.allHTTPHeaderFields?["Content-Type"])
	}
	
	func testFetchSuccess() async {
		//Given
		let endpoint = URL(string: "https://example.com")!
		var request = URLRequest(url: endpoint)
		request.httpMethod = Constants.method
		
		let (_, expectedData, _) = mockData.makeMock(for: .success)
		//When
		do {
			let data = try await apiService.fetch(request: request)
			//Then
			XCTAssertEqual(data, expectedData)
		} catch {
			XCTFail("Unexpected error type: \(error)")
		}
	}
	
	func testFetchInvalidResponseOccurs() async {
		//Given
		let endpoint = URL(string: "https://example.com")!
		var request = URLRequest(url: endpoint)
		request.httpMethod = Constants.method
		
		// Simuler une réponse avec des données
		let (_, _, _) = mockData.makeMock(for: .serverError)
		
		//When & Then
		do {
			_ = try await apiService.fetch(request: request)
			XCTFail("Expected to throw APIError.invalidParameters but succeeded")
		} catch APIError.invalidResponse {
			XCTAssertTrue(true, "Caught expected APIError.invalidResponse")
		} catch {
			XCTFail("Expected APIError.invalidParameters, got \(error)")
		}
	}

	func testFetchStatusCodeErrorOccurs() async {
		//Given
		let endpoint = URL(string: "https://example.com")!
		var request = URLRequest(url: endpoint)
		request.httpMethod = Constants.method
		
		// Simuler une réponse avec des données
		let (_, _, _) = mockData.makeMock(for: .statusCodeError)
		//When & Then
		do {
			_ = try await apiService.fetch(request: request)
			XCTFail("Expected to throw APIError.httpError but succeeded")
		} catch APIError.httpError(statusCode: 500) {
			XCTAssertTrue(true, "Caught expected APIError.httpError")
		} catch {
			XCTFail("Expected APIError.invalidParameters, got \(error)")
		}
	}
	
	func testFetchNetworkErrorOccurs() async {
		let endpoint = URL(string: "invalid-url")!
		var request = URLRequest(url: endpoint)
		request.httpMethod = Constants.method
		
		let (_, _, _) = mockData.makeMock(for: .networkError)
		
		do {
			_ = try await apiService.fetch(request: request)
			XCTFail("Expected to throw network error but it succeeded")
		} catch let error as NSError {
			// Vérifie si c'est une erreur réseau (en fonction de la nature de l'erreur)
			XCTAssertTrue(error.domain == NSURLErrorDomain)
		} catch {
			XCTFail("Unexpected error: \(error)")
		}
	}
	
	func testDecodeSuccess() {
		//Given
		let (_,expectedData,_) = mockData.makeMock(for: .success)
		guard let data = expectedData else {
			return
		}
		//When & Then
		do {
			let responseJSON = try apiService.decode([Product].self, data: data)
			guard let responseJSON = responseJSON else {
				XCTFail("Decoded response is nil")
				return
			}
			XCTAssertEqual(responseJSON[0].likes, 56)
		} catch {
			XCTFail("Unexpected error type: \(error)")
		}
	}
	
	func testDecodeDecodingErrorOccurs() {
		//Given
		let (_,expectedData,_) = mockData.makeMock(for: .success)
		guard let data = expectedData else {
			return
		}
		//When & Then
		do {
			let responseJSON = try apiService.decode([Product].self, data: data)
			guard responseJSON != nil else {
				XCTFail("Decoded response is nil")
				return
			}
		} catch APIError.decodingError {
			XCTAssertTrue(true, "Caught expected APIError.decodingError")
		} catch {
			XCTFail("Unexpected error type: \(error)")
		}
	}
	
	func testFetchAndDecodeWithoutBodySuccess() async {
		//Given
		let endpoint = URL(string: "https://example.com")!
		var request = URLRequest(url: endpoint)
		request.httpMethod = Constants.method
		
		let (_,_,_) = mockData.makeMock(for: .success)
		//When & Then
		do {
			let decodedData = try await apiService.fetchAndDecode([Product].self, request: request)
			XCTAssertNotNil(decodedData)
		} catch {
			XCTFail("Unexpected error type: \(error)")
		}
	}
	
	func testFetchAndDecodeEmptyData() async {
		//Given
		let endpoint = URL(string: "https://example.com")!
		var request = URLRequest(url: endpoint)
		request.httpMethod = Constants.method
		
		let (_,_,_) = mockData.makeMock(for: .emptyData)
		//When & Then
		do {
			_ = try await apiService.fetchAndDecode([Product].self, request: request)
		} catch APIError.emptyData {
			XCTAssertTrue(true, "Caught expected APIError.emptyData")
		} catch {
			XCTFail("Unexpected error type: \(error)")
		}
	}
}
