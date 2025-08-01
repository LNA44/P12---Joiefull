//
//  CategoryItem.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import SwiftUI

struct CategoryItem: View {
	var product: Product
	
	var body: some View {
		VStack(alignment: .leading) {
			ZStack {
				if let url = product.picture.imageURL { //optionnel donc vérif pas nil
					AsyncImageView(url: url)
						.accessibilityElement()
						.accessibilityLabel("\(product.picture.description)")
				}
				
				LikesPill(product: product)
					.offset(x: 60, y: 75)
			}
			
			VStack(spacing: 3) {
				HStack(alignment: .top) {
					VStack(alignment: .leading, spacing: 0) {
						Text(product.name)
							.font(.system(size: 14, weight: .semibold, design: .default))
							.multilineTextAlignment(.leading)
							.lineLimit(nil)       // aucune limite de lignes
							.fixedSize(horizontal: false, vertical: true)
							.accessibilityHidden(true)
					}
					Spacer()
					HStack(spacing: 2) {
						Image(systemName: "star.fill")
							.foregroundColor(.orange)
							.font(.system(size: 12))
						Text("10")
							.font(.system(size: 14))
					}
					.accessibilityElement()
					.accessibilityLabel("10 personnes l'ont ajouté en favoris")
					//.accessibilityLabel("\(nombreFavoris) personnes l'ont ajouté en favoris")
				}
				.frame(maxWidth: 182)
				
				HStack {
					Text("\(String(format: "%.0f", product.price))€") //arrondi 0 chiffres aprèsla virgule
							.font(.system(size: 14))
					
					Spacer()
					Text(String("\(String(format: "%.0f", product.originalPrice))€"))
						.strikethrough(true, color: Color.black.opacity(0.8))
						.font(.system(size: 14))
						.foregroundColor(Color.black.opacity(0.8))
				}
				.accessibilityElement()
				.accessibilityLabel("Prix réduit : \(Int(product.price)) euros; prix d'origine : \(Int(product.originalPrice)) euros, barré.")
				Spacer()
			}
			.padding(.horizontal, 8)
			.frame(height: 65)
		}
		.padding(.leading, 15)
		.padding(.trailing, -5)
	}
}

#Preview {
	let product = Product(id: 32, picture: Product.Picture(url: "", description: ""), name: "test", likes: 10, price: 100, originalPrice: 110, category: .bottoms)
	CategoryItem(product: product)
}
