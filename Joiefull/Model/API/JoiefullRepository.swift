//
//  JoiefullRepository.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import Foundation

protocol JoiefullRepositoryProtocol {
	func fetchProducts() async throws -> [Product]
}

struct JoiefullRepository: JoiefullRepositoryProtocol {
	//MARK: -Private properties
	private let APIService: JoiefullAPIService
	
	//MARK: -Initialization
	init(APIService: JoiefullAPIService = JoiefullAPIService()) {
		self.APIService = APIService
	}
	
	//MARK: -Methods
	func fetchProducts() async throws -> [Product] {
		let endpoint = try APIService.createEndpoint()
		let request = APIService.createRequest(endpoint: endpoint)
		let responseJSON = try await APIService.fetchAndDecode([Product].self, request: request)
		if responseJSON.isEmpty {
			throw APIError.emptyData
		}
		return responseJSON
	}
}
