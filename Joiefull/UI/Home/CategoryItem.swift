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
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	var isSelected = false
	
	var product: Product
	
	var body: some View {
		let imageWidth: CGFloat = horizontalSizeClass == .compact ? 198 : 221
		let imageHeight: CGFloat = horizontalSizeClass == .compact ? 198 : 254
		VStack(spacing: 10) {
			ZStack {
				if let url = product.picture.imageURL { //optionnel donc vérif pas nil
					AsyncImageView(url: url, width: imageWidth, height: imageHeight)
						.overlay(
							RoundedRectangle(cornerRadius: 16)
								.stroke(isSelected ? (Color("SelectedItem")) : Color.clear, lineWidth: 4)
						)
						.accessibilityElement()
						.accessibilityLabel("\(product.picture.description)")
				}
				
				ZStack {
					Button (action: {
					}) {
						RoundedRectangle(cornerRadius: 20)
							.fill(Color.white)
							.frame(width:CGFloat(51), height:CGFloat(27))
							.offset(x: horizontalSizeClass == .compact ? 80 : 90, y: horizontalSizeClass == .compact ? 75 : 95)
						
						HStack(spacing: 5) {
							Image(systemName: favoriteVM.isFavorite(product.id) ? "heart.fill" : "heart")
								.frame(width: CGFloat(14))
								.foregroundColor(.black)
							
							Text("\(favoriteVM.likesCount(for: product.id))")
								.font(.system(size: CGFloat(14), weight: .semibold, design: .default))
								.foregroundColor(.black)
						}
						.offset(x: horizontalSizeClass == .compact ? 28 : 39,  y: horizontalSizeClass == .compact ? 75 : 95)
					}
				}
				.accessibilityElement()
				.accessibilityLabel("Le produit a été aimé par \(product.likes) d'utilisateurs")
			}
			//.background(Color.orange)
			
			VStack(spacing: 3) {
				HStack(alignment: .top) {
					VStack {
						Text(product.name)
							.foregroundColor(isSelected ? Color("SelectedItem") : Color.primary)
							.font(.system(
								size: horizontalSizeClass == .compact ? 14 : 18,
								weight: .semibold,
								design: .default
							))
							.multilineTextAlignment(.leading)
							.lineLimit(nil)       // aucune limite de lignes
							.fixedSize(horizontal: false, vertical: true)
							.accessibilityHidden(true)
					}
					Spacer()
					HStack(spacing: 2) {
						Image(systemName: "star.fill")
							.foregroundColor(.orange)
							.font(.system(
								size: horizontalSizeClass == .compact ? 12 : 18,
							))
						Text(String(format: "%.1f", ratingsVM.getAverage(for: product.id)))
							.foregroundColor(isSelected ? Color("SelectedItem") : Color.primary)
							.font(.system(
								size: horizontalSizeClass == .compact ? 14 : 18,
							))
					}
					.accessibilityElement()
					.accessibilityLabel("Ce produit a reçu une note moyenne de \(String(format: "%.1f", ratingsVM.getAverage(for: product.id))) sur 5 étoiles")
				}
				//.background(Color.green)
				
				HStack {
					Text("\(String(format: "%.0f", product.price))€") //arrondi 0 chiffres après la virgule
						.foregroundColor(isSelected ? Color("SelectedItem") : Color.primary)
						.font(.system(
							size: horizontalSizeClass == .compact ? 14 : 18,
						))
					
					Spacer()
					Text(String("\(String(format: "%.0f", product.originalPrice))€"))
						.strikethrough(true, color: isSelected ? Color("SelectedItem") : Color.black.opacity(0.8))
						.foregroundColor(isSelected ? Color("SelectedItem") : Color.primary)
						.font(.system(
							size: horizontalSizeClass == .compact ? 14 : 18,
						))
						.foregroundColor(Color.black.opacity(0.8))
				}
				//.background(Color.yellow)
				.accessibilityElement()
				.accessibilityLabel("Prix réduit : \(Int(product.price)) euros; prix d'origine : \(Int(product.originalPrice)) euros, barré.")
			}
			//.background(Color.brown)
			.padding(.horizontal, 5)
			.frame(maxWidth: imageWidth)
			Spacer()
		}
		.onAppear {
			// Initialiser les likes
			if favoriteVM.likesCount(for: product.id) == 0 {
				favoriteVM.setInitialLikes(for: product.id, count: product.likes)
			}
		}
		.frame(height: horizontalSizeClass == .compact ? 260 : 330)//hauteur du gris
	}
}

/*#Preview {
 let product = Product(id: 32, picture: Product.Picture(url: "https://raw.githubusercontent.com/LNA44/P12---Creez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg", description: ""), name: "test", likes: 10, price: 100, originalPrice: 110, category: .bottoms)
 CategoryItem(product: product)
 }*/
