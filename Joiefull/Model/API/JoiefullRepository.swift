//
//  JoiefullRepository.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import Foundation

struct JoiefullRepository {
	//MARK: -Properties
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
		guard let unwrappedResponseJSON = responseJSON else {
			throw APIError.emptyData
		}
		return unwrappedResponseJSON
	}
}
