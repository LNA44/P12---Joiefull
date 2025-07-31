//
//  CategoryRow.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import SwiftUI

struct CategoryRow: View {
	var categoryName: String
	var items: [Product]
    var body: some View {
			VStack {
				Text(categoryName)
					.font(.system(size: 22, weight: .semibold, design: .default))
					.padding(.leading, 15)
					.padding(.top, 5)
			}
			ScrollView(.horizontal, showsIndicators: false) {
				HStack (alignment: .top, spacing: 0){
					ForEach(items) { product in
						NavigationLink(destination: DetailsView(product: product)) {
							CategoryItem(product: product)
						}
						.buttonStyle(PlainButtonStyle())
					}
				}
			}
			.frame(height: 300)
	}
}

/*#Preview {
	let products = [Product(id: 1, picture: Product.Picture(url: "", description: ""), name: "test", likes: 10, price: 100, originalPrice: 110, category: .bottoms)]
    return CategoryRow(
		categoryName: products[0].category.rawValue,
		items: Array(products.prefix(3))
	)
}*/
