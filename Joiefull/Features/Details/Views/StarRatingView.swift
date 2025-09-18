//
//  StarRatingView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 31/07/2025.
//

import SwiftUI

struct StarRatingView: View {
	//MARK: -Public properties
	@Binding var rating: Double //lié au get/set de detailsView, permet d'envoyer ou de récupérer des données du VM
	var maximumRating = 5
	var starSize: CGFloat = 30
	var onColor = Color.orange
	var offColor = Color.gray
	
	//MARK: -Body
	var body: some View {
		HStack(spacing: 8) {
			ForEach(1...maximumRating, id: \.self) { number in
				Image(systemName: number <= Int(rating) ? "star.fill" : "star")
					.resizable()
					.frame(width: starSize, height: starSize)
					.foregroundColor(number <= Int(rating) ? onColor : offColor)
					.onTapGesture {
						rating = Double(number)
					}
			}
		}
	}
}

	//MARK: -Preview
struct StarRatingView_Previews: PreviewProvider {
	
	@State static var previewRating: Double = 3.0
	
	static var previews: some View {
		Group {
			// Preview simple
			StarRatingView(rating: $previewRating)
				.previewDisplayName("Par défaut")
			
			// Preview avec paramètres personnalisés
			StarRatingView(
				rating: $previewRating,
				maximumRating: 10,
				starSize: 20,
				onColor: .yellow,
				offColor: .blue
			)
			.previewDisplayName("Personnalisé")
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
