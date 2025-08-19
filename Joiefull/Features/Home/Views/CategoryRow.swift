//
//  CategoryRow.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import SwiftUI

struct CategoryRow: View {
	//MARK: -Public properties
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	@EnvironmentObject var ratingsVM: RatingsViewModel
	@EnvironmentObject var favoriteVM: FavoriteViewModel
	var categoryName: String
	var items: [Product] = []
	var selectedProduct: Binding<Product?>? //afficher la vue detail sur ipad sans naviguer (changer d'écran), optionnel pour n'être utilisé que sur iPad
	
	//MARK: -Initialization
	init(categoryName: String = "", items: [Product] = [], selectedProduct: Binding<Product?>? = nil) {
		self.categoryName = categoryName
		self.items = items
		self.selectedProduct = selectedProduct
	}
	
	//MARK: -Body
	var body: some View {
		VStack {
			HStack {
				Text(categoryName)
					.font(.system(size: 22, weight: .semibold, design: .default))
					.accessibilityAddTraits(.isHeader)
				Spacer()
			}
			.padding(.top, horizontalSizeClass == .compact ? 10 : 0)
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 10) {
					ForEach(items) { product in
						productView(for: product)
							.accessibilityElement(children: .ignore)
							.accessibilityLabel("Produit \(product.name), note moyenne\(String(format: "%.1f", ratingsVM.getAverage(for: product.id))) sur 5 étoiles, prix réduit \(String(format: "%.0f", product.price)) euros, prix d'origine \(String(format: "%.0f", product.originalPrice)) euros. Le produit a été aimé par \(product.likes) d'utilisateurs.")
							.accessibilityAddTraits(.isButton)
					}
					
				}
			}
			.frame(height: horizontalSizeClass == .compact ? 300 : 330) //hauteur du rose
		}
		.padding(.leading, 15)
	}
	
	@ViewBuilder
	private func productView(for product: Product) -> some View {
		if horizontalSizeClass == .compact {
			//iPhone: navigation
			NavigationLink(destination: DetailsView(product: product)
						   //.background(Color("Background"))
				.environmentObject(ratingsVM)
				.environmentObject(favoriteVM)
			) {
				CategoryItem(product: product)
					.frame(maxHeight: .infinity, alignment: .top)
				
			}
			.buttonStyle(PlainButtonStyle())
		} else {
			//Ipad: pas de nav juste afficher DetailsView
			Button {
				selectedProduct?.wrappedValue = product
			} label: {
				CategoryItem(isSelected: selectedProduct?.wrappedValue == product, product: product)
					.environmentObject(ratingsVM)
					.environmentObject(favoriteVM)
			}
			.buttonStyle(PlainButtonStyle())
		}
		
	}
}

//MARK: -Preview
struct CategoryRow_Previews: PreviewProvider {
	
	// Mock Product
	static var fakeProducts: [Product] = [
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
		),
		Product(
			id: 2,
			picture: Product.Picture(
				url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/1.jpg",
				description: "Modèle femme qui porte un jean et un haut jaune"
			),
			name: "Robe",
			likes: 24,
			price: 70,
			originalPrice: 80,
			category: .bottoms
		),
		Product(
			id: 1,
			picture: Product.Picture(
				url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/1.jpg",
				description: "Haut vert"
			),
			name: "T-shirt",
			likes: 32,
			price: 25,
			originalPrice: 32,
			category: .tops
		)
	]
	
	static var previews: some View {
		CategoryRow(categoryName: "Hauts", items: fakeProducts)
			.environmentObject(RatingsViewModel())  // utilise données ratingsMock par défaut
			.environmentObject(FavoriteViewModel()) // idem pour favoris
	}
}
