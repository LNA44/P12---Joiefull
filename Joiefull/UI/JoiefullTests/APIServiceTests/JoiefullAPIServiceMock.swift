//
//  JoiefullAPIServiceMock.swift
//  JoiefullTests
//
//  Created by Ordinateur elena on 12/08/2025.
//

import XCTest
@testable import Joiefull

enum MockScenarioAPIService {
	case success
	case serverError
	case statusCodeError
	case networkError
	case decodingError
	case emptyData
}

final class JoiefullAPIServiceMock {
	
	func makeMock(for scenario: MockScenarioAPIService) -> (URLResponse?, Data?, Error?) {
		switch scenario {
		case .success:
			let response = HTTPURLResponse(url: URL(string: "http://localhost/mock")!,
										   statusCode: 200,
										   httpVersion: nil,
										   headerFields: nil)!
			let jsonData = """
			[
			  {
				"id": 0,
				"picture": {
				  "url": "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg",
				  "description": "Sac à main orange posé sur une poignée de porte"
				},
				"name": "Sac à main orange",
				"category": "ACCESSORIES",
				"likes": 56,
				"price": 69.99,
				"original_price": 69.99
			  },
			  {
				"id": 1,
				"picture": {
				  "url": "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/1.jpg",
				  "description": "Modèle femme qui porte un jean et un haut jaune"
				},
				"name": "Jean pour femme",
				"category": "BOTTOMS",
				"likes": 55,
				"price": 49.99,
				"original_price": 59.99
			  },
			  {
				"id": 2,
				"picture": {
				  "url": "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/shoes/1.jpg",
				  "description": "Modèle femme qui pose dans la rue en bottes de pluie noires"
				},
				"name": "Bottes noires pour l'automne",
				"category": "SHOES",
				"likes": 4,
				"price": 99.99,
				"original_price": 119.99
			  }
			]
			""".data(using: .utf8)!
			
			MockURLProtocol.requestHandler = { request in
				return (response, jsonData, nil) // Réponse simulée
			}
			
			return (response, jsonData, nil)
	
		case .serverError:
			let response = URLResponse(url: URL(string: "http://localhost/mock")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
			let jsonData = """
			[
			  {
				"id": 0,
				"picture": {
				  "url": "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg",
				  "description": "Sac à main orange posé sur une poignée de porte"
				},
				"name": "Sac à main orange",
				"category": "ACCESSORIES",
				"likes": 56,
				"price": 69.99,
				"original_price": 69.99
			  },
			  {
				"id": 1,
				"picture": {
				  "url": "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/1.jpg",
				  "description": "Modèle femme qui porte un jean et un haut jaune"
				},
				"name": "Jean pour femme",
				"category": "BOTTOMS",
				"likes": 55,
				"price": 49.99,
				"original_price": 59.99
			  },
			  {
				"id": 2,
				"picture": {
				  "url": "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/shoes/1.jpg",
				  "description": "Modèle femme qui pose dans la rue en bottes de pluie noires"
				},
				"name": "Bottes noires pour l'automne",
				"category": "SHOES",
				"likes": 4,
				"price": 99.99,
				"original_price": 119.99
			  }
			]
			""".data(using: .utf8)!
			
			MockURLProtocol.requestHandler = { request in
				return (response, jsonData, nil) // Réponse simulée
			}
			
			return (response, jsonData, nil)
			
		case .statusCodeError:
			let response = HTTPURLResponse(url: URL(string: "http://localhost/mock")!,
										   statusCode: 500,
										   httpVersion: nil,
										   headerFields: nil)!
			let jsonData = """
			[
			  {
				"id": 0,
				"picture": {
				  "url": "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg",
				  "description": "Sac à main orange posé sur une poignée de porte"
				},
				"name": "Sac à main orange",
				"category": "ACCESSORIES",
				"likes": 56,
				"price": 69.99,
				"original_price": 69.99
			  },
			  {
				"id": 1,
				"picture": {
				  "url": "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/1.jpg",
				  "description": "Modèle femme qui porte un jean et un haut jaune"
				},
				"name": "Jean pour femme",
				"category": "BOTTOMS",
				"likes": 55,
				"price": 49.99,
				"original_price": 59.99
			  },
			  {
				"id": 2,
				"picture": {
				  "url": "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/shoes/1.jpg",
				  "description": "Modèle femme qui pose dans la rue en bottes de pluie noires"
				},
				"name": "Bottes noires pour l'automne",
				"category": "SHOES",
				"likes": 4,
				"price": 99.99,
				"original_price": 119.99
			  }
			]
			""".data(using: .utf8)!
			
			MockURLProtocol.requestHandler = { request in
				return (response, jsonData, nil) // Réponse simulée
			}
			
			return (response, jsonData, nil)
			
			
		case .networkError:
			let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: [NSLocalizedDescriptionKey: "No Internet Connection"])
			MockURLProtocol.requestHandler = { request in
				return (nil, nil, error) // Réponse simulée
			}
			
			return (nil, nil, error)
			
		case .decodingError:
			let response = HTTPURLResponse(url: URL(string: "http://localhost/mock")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
			
			let jsonData = """
		  {
		   "date": Date()
		  }
		  """.data(using: .utf8)!
			
			MockURLProtocol.requestHandler = { request in
				return (response, jsonData, nil) // Réponse simulée
			}
			
			return (response, jsonData, nil)
			
		case .emptyData:
			let response = HTTPURLResponse(url: URL(string: "http://localhost/mock")!,
										   statusCode: 200,
										   httpVersion: nil,
										   headerFields: nil)!
			
			MockURLProtocol.requestHandler = { request in
				return (response, Data(), nil) // Réponse simulée
			}
			
			return (response, Data(), nil)
	
		}
	}
}
