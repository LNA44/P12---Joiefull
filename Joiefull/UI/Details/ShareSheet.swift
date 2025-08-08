//
//  ShareSheet.swift
//  Joiefull
//
//  Created by Ordinateur elena on 01/08/2025.
//

import SwiftUI
import UIKit

struct ShareSheet: UIViewControllerRepresentable { //création vue en UIKit dans app en SwiftUI
	var productImageURL: String
	var defaultComment: String
	@Binding var isPresented: Bool
	
	func makeUIViewController(context: Context) -> UIActivityViewController {
		// On prépare les éléments à partager
		let urlString = convertStringToURL(string: productImageURL)?.absoluteString ?? "Lien non disponible"
		let message = "\(defaultComment)\n\n Voici le lien vers l'image du produit : \(urlString))"
		
		let activityVC = UIActivityViewController(activityItems: [message], applicationActivities: nil)
		
		activityVC.completionWithItemsHandler = { _, _, _, _ in //calback après partage de l'utilisateur
			isPresented = false
		}
		
		return activityVC
	}
	
	func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { //utile quand valeurs doient changer après affiche du VC
	}
	
	func convertStringToURL(string: String) -> URL? {
			return URL(string: string)
	}
}
