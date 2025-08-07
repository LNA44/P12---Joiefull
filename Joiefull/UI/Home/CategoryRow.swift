//
//  CategoryRow.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import SwiftUI

struct CategoryRow: View {
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	var categoryName: String
	var items: [Product] = []
	@AccessibilityFocusState private var isFocused: Bool
	@EnvironmentObject var ratingsVM: RatingsViewModel
	@EnvironmentObject var favoriteVM: FavoriteViewModel
	var selectedProduct: Binding<Product?>? //afficher la vue detail sur ipad sans naviguer (changer d'écran), Optionnel pour n'être utilisé que sur iPad
	
	init(categoryName: String = "", items: [Product] = [], selectedProduct: Binding<Product?>? = nil) {
		self.categoryName = categoryName
		self.items = items
		self.selectedProduct = selectedProduct
	}
	
    var body: some View {
		VStack {
			HStack {
				Text(categoryName)
					.font(.system(size: 22, weight: .semibold, design: .default))
				Spacer()
			}
			.padding(.top, horizontalSizeClass == .compact ? 10 : 0)
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 10) {
					ForEach(items) { product in
						productView(for: product)
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
				.background(Color("Background"))
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
			}
			.buttonStyle(PlainButtonStyle())
		}
		
	}
}

/*#Preview {
	let products = [Product(id: 1, picture: Product.Picture(url: "", description: ""), name: "test", likes: 10, price: 100, originalPrice: 110, category: .bottoms)]
    return CategoryRow(
		categoryName: products[0].category.rawValue,
		items: Array(products.prefix(3))
	)
}*/
