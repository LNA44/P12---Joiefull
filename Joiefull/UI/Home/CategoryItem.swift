//
//  CategoryItem.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import SwiftUI

struct CategoryItem: View {
	//MARK: -Public properties
	@EnvironmentObject var ratingsVM: RatingsViewModel
	@EnvironmentObject var favoriteVM: FavoriteViewModel
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	var isSelected = false
	var product: Product
	
	//MARK: -Private properties
	private var imageWidth: CGFloat {
		horizontalSizeClass == .compact ? 198 : 221
	}

	private var imageHeight: CGFloat {
		horizontalSizeClass == .compact ? 198 : 254
	}
	
	//MARK: -Body
	var body: some View {
		VStack(spacing: 10) {
			productImageSection
			
			VStack(spacing: 3) {
				productNameAndRating
				productPrice
			}
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
	
	//MARK: -Sections
	private var productImageSection: some View {
		ZStack {
			if let url = product.picture.imageURL { //optionnel donc vérif pas nil
				AsyncImageView(url: url, width: imageWidth, height: imageHeight)
					.overlay(
						RoundedRectangle(cornerRadius: 16)
							.stroke(isSelected ? (Color("SelectedItem")) : Color.clear, lineWidth: 4)
					)
					//.accessibilityLabel("\(product.picture.description)")
					//.accessibilityAddTraits(.isImage)
			}
			favoriteButton
		}
	}
	
	private var favoriteButton: some View {
		ZStack {
			Button (action: {
			}) {
				RoundedRectangle(cornerRadius: 20)
					.fill(Color.white)
					.frame(width:CGFloat(51), height:CGFloat(27))
					.offset(x: horizontalSizeClass == .compact ? 80 : 90, y: horizontalSizeClass == .compact ? 75 : 95)
					.accessibilityHidden(true)
				
				HStack(spacing: 5) {
					Image(systemName: favoriteVM.isFavorite(product.id) ? "heart.fill" : "heart")
						.frame(width: CGFloat(14))
						.foregroundColor(.black)
						.accessibilityHidden(true)
					
					Text("\(favoriteVM.likesCount(for: product.id))")
						.font(.system(size: CGFloat(14), weight: .semibold, design: .default))
						.foregroundColor(.black)
						.accessibilityHidden(true)
				}
				.offset(x: horizontalSizeClass == .compact ? 28 : 39,  y: horizontalSizeClass == .compact ? 75 : 95)
			}
			//.accessibilityLabel("Le produit a été aimé par \(product.likes) d'utilisateurs")
		}
	}
	
	var productNameAndRating: some View {
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
					//.accessibilityLabel("Le nom de cet article est \(product.name)")
			}
			Spacer()
			HStack(spacing: 2) {
				Image(systemName: "star.fill")
					.foregroundColor(.orange)
					.font(.system(
						size: horizontalSizeClass == .compact ? 12 : 18,
					))
					.accessibilityHidden(true)
				Text(String(format: "%.1f", ratingsVM.getAverage(for: product.id)))
					.foregroundColor(isSelected ? Color("SelectedItem") : Color.primary)
					.font(.system(
						size: horizontalSizeClass == .compact ? 14 : 18,
					))
					.accessibilityHidden(true)
			}
			//.accessibilityElement()
			//.accessibilityLabel("Ce produit a reçu une note moyenne de \(String(format: "%.1f", ratingsVM.getAverage(for: product.id))) sur 5 étoiles")
		}
	}
	
	var productPrice: some View {
		HStack {
			Text("\(String(format: "%.0f", product.price))€") //arrondi 0 chiffres après la virgule
				.foregroundColor(isSelected ? Color("SelectedItem") : Color.primary)
				.font(.system(
					size: horizontalSizeClass == .compact ? 14 : 18,
				))
				.accessibilityHidden(true)
			
			Spacer()
			Text(String("\(String(format: "%.0f", product.originalPrice))€"))
				.strikethrough(true, color: isSelected ? Color("SelectedItem") : Color.black.opacity(0.8))
				.foregroundColor(isSelected ? Color("SelectedItem") : Color.primary)
				.font(.system(
					size: horizontalSizeClass == .compact ? 14 : 18,
				))
				.foregroundColor(Color.black.opacity(0.8))
				.accessibilityHidden(true)
		}
		//.accessibilityElement() //avec plsrs éléments, permet de les regrouper en une description
		//.accessibilityLabel("Prix réduit : \(String(format: "%.0f", product.price)) euros; prix d'origine : \(String(format: "%.0f", product.originalPrice)) euros")
	}
}

/*#Preview {
 let product = Product(id: 32, picture: Product.Picture(url: "https://raw.githubusercontent.com/LNA44/P12---Creez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg", description: ""), name: "test", likes: 10, price: 100, originalPrice: 110, category: .bottoms)
 CategoryItem(product: product)
 }*/
