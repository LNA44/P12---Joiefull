//
//  APIService.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import Foundation

struct JoiefullAPIService {
	//MARK: -Private properties
	private let session: URLSession
	
	//MARK: -Initialization
	init(session: URLSession = .shared) {
		self.session = session
	}
	
	//MARK: -Methods
	func createEndpoint() throws -> URL {
		guard let baseURL = URL(string: Constants.baseURL) else {
			throw APIError.invalidURL
		}
		return baseURL
	}
	
	func createRequest(endpoint: URL) -> URLRequest {
		var request = URLRequest(url: endpoint)
		request.httpMethod = Constants.method
		return request
	}
	
	func fetch(request: URLRequest) async throws -> Data {
		let (data, response) = try await session.data(for: request)
		guard let httpResponse = response as? HTTPURLResponse else {
			throw APIError.invalidResponse
		}
		guard httpResponse.statusCode == 200 else {
			throw APIError.httpError(statusCode: httpResponse.statusCode)
		}
		return data
	}
	
	func decode<T: Decodable>(_ type: T.Type, data: Data) throws -> T {
		if data.isEmpty {
			if let emptyArray = [] as? T {
				return emptyArray
			} else {
				throw APIError.decodingError
			}
		}
		do {
			let responseJSON = try JSONDecoder().decode(T.self, from: data)
			return responseJSON
		} catch {
			// Ici on attrape toutes les erreurs de décodage et on renvoie APIError.decodingError
			throw APIError.decodingError
		}
	}

	func fetchAndDecode<T: Decodable>(_ type: T.Type, request: URLRequest) async throws -> T {
		let data = try await fetch(request: request)
		let decodedData = try decode(T.self, data: data)
		return decodedData
	}
}
