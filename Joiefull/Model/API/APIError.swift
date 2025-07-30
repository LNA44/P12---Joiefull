//
//  APIError.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import Foundation

enum APIError: LocalizedError, Equatable {
	case invalidURL
	case invalidResponse
	case httpError(statusCode: Int)
	case emptyData
	case decodingError
	
	var errorDescription: String? {
		switch self {
		case .invalidURL:
			return "The URL is invalid."
		case .invalidResponse: //response autre type que HTTPURLResponse
			return "Invalid response from the server."
		case .httpError(let statusCode):
			return "HTTP error: \(statusCode)"
		case .emptyData:
			return "No data received from the server."
		case .decodingError:
			return "Decoding error."
		}
	}
}
