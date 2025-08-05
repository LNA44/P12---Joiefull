//
//  CategoryItem.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import SwiftUI

struct CategoryItem: View {
	@EnvironmentObject var ratingsVM: RatingsViewModel
	@EnvironmentObject var favoriteVM: FavoriteViewModel

	var product: Product

	var body: some View {
		VStack() {
			ZStack {
				if let url = product.picture.imageURL { //optionnel donc vérif pas nil
					AsyncImageView(url: url)
						.accessibilityElement()
						.accessibilityLabel("\(product.picture.description)")
				}
				
				ZStack {
					Button (action: {
					}) {
						RoundedRectangle(cornerRadius: 20)
							.fill(Color.white)
							.frame(width:CGFloat(51), height:CGFloat(27))
							.offset(x: 80, y: 75)

						HStack(spacing: 5) {
							Image(systemName: favoriteVM.isFavorite(product.id) ? "heart.fill" : "heart")
								.frame(width: CGFloat(14))
								.foregroundColor(.black)
							
							Text("\(favoriteVM.likesCount(for: product.id))")
								.font(.system(size: CGFloat(14), weight: .semibold, design: .default))
								.foregroundColor(.black)
						}
						.offset(x: 28, y: 75)
					}
				}
				.accessibilityElement()
				.accessibilityLabel("Le produit a été aimé par \(product.likes) d'utilisateurs")
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
						Text(String(format: "%.1f", ratingsVM.getAverage(for: product.id)))
							.font(.system(size: 14))
					}
					.accessibilityElement()
					.accessibilityLabel("Ce produit a reçu une note moyenne de \(String(format: "%.1f", ratingsVM.getAverage(for: product.id))) sur 5 étoiles")
				}
				
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
			.frame(maxWidth: 182)
			.frame(height: 65)
		}
		.onAppear {
			// Initialiser les likes
			if favoriteVM.likesCount(for: product.id) == 0 {
				favoriteVM.setInitialLikes(for: product.id, count: product.likes)
			}
		}
		.padding(.leading, 15)
		.padding(.trailing, -5)
	}
}

/*#Preview {
	let product = Product(id: 32, picture: Product.Picture(url: "https://raw.githubusercontent.com/LNA44/P12---Creez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg", description: ""), name: "test", likes: 10, price: 100, originalPrice: 110, category: .bottoms)
	CategoryItem(product: product)
}*/
