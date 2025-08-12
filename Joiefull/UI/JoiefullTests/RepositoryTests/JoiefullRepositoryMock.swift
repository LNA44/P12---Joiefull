//
//  JoiefullRepositoryMock.swift
//  JoiefullTests
//
//  Created by Ordinateur elena on 12/08/2025.
//

import XCTest
@testable import Joiefull

enum MockScenarioJoiefullRepository {
	case success
	case emptyData
}

struct JoiefullRepositoryMock {
	func makeMock(for scenario: MockScenarioJoiefullRepository) -> (URLResponse?, Data?, Error?) {
		switch scenario {
		case .success:
			let response = HTTPURLResponse(url: URL(string: "http://localhost/mock")!,
										   statusCode: 200,
										   httpVersion: nil,
										   headerFields: nil)! //url fictive car pas d'API utilisée -> fichier JSON sur GitHub
			
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
			
		case .emptyData:
			let response = HTTPURLResponse(url: URL(string: "http://localhost/mock")!,
										   statusCode: 200,
										   httpVersion: nil,
										   headerFields: nil)! //url fictive car pas d'API utilisée -> fichier JSON sur GitHub
			
			MockURLProtocol.requestHandler = { request in
				return (response, Data(), nil)
			}
			
			return (response, Data(), nil)
		}
	}
}
