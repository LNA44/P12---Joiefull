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
	@Environment(\.colorScheme) var colorScheme
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
		.frame(height: horizontalSizeClass == .compact ? 260 : 330)
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
			}
			Spacer()
			HStack(spacing: 2) {
				Image(systemName: "star.fill")
					.foregroundColor(.orange)
					.font(.system(
						size: horizontalSizeClass == .compact ? 12 : 18
					))
					.accessibilityHidden(true)
				Text(String(format: "%.1f", ratingsVM.getAverage(for: product.id)))
					.foregroundColor(isSelected ? Color("SelectedItem") : Color.primary)
					.font(.system(
						size: horizontalSizeClass == .compact ? 14 : 18
					))
					.accessibilityHidden(true)
			}
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
				.strikethrough(true, color: colorScheme == .dark ? Color.white : Color.black.opacity(0.8))
				.foregroundColor(isSelected ? Color("SelectedItem") : Color.primary)
				.font(.system(
					size: horizontalSizeClass == .compact ? 14 : 18,
				))
				.foregroundColor(Color.black.opacity(0.8))
				.accessibilityHidden(true)
		}
	}
}

//MARK: -Preview
struct CategoryItem_Previews: PreviewProvider {
	static var fakeProduct: Product =
	Product(
		id: 1,
		picture: Product.Picture(
			url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/1.jpg",
			description: "Modèle femme qui porte un jean et un haut jaune"
		),
		name: "Jean pour femme",
		likes: 24,
		price: 89.99,
		originalPrice: 129.99,
		category: .tops
	)
	
	static var previews: some View {
		Group {
			CategoryItem(isSelected: false, product: fakeProduct)
				.environmentObject(RatingsViewModel())
				.environmentObject(FavoriteViewModel())
				.previewDevice("iPhone 14")
			
			CategoryItem(isSelected: true, product: fakeProduct)
				.environmentObject(RatingsViewModel())
				.environmentObject(FavoriteViewModel())
				.previewDevice("iPad Pro (12.9-inch) (6th generation)")
		}
	}
}
