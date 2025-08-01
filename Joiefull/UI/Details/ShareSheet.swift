//
//  ShareSheet.swift
//  Joiefull
//
//  Created by Ordinateur elena on 01/08/2025.
//

import SwiftUI
import UIKit

struct ShareSheet: UIViewControllerRepresentable { //création vue en UIKit dans app en SwiftUI
	var comment: String
	var productDescription: String
	@Binding var isPresented: Bool
	
	func makeUIViewController(context: Context) -> UIActivityViewController {
		let message = "\(comment)\n\nDescription du produit : \(productDescription)"
		let activityVC = UIActivityViewController(activityItems: [message], applicationActivities: nil)
		
		activityVC.completionWithItemsHandler = { _, _, _, _ in //calback après partage de l'utilisateur
			isPresented = false
		}
		
		return activityVC
	}
	
	func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { //utile quand valeurs doient changer après affiche du VC
	}
}
