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
					asyncImage(from: url)
				}
				
				LikesPill(product: product)
					.offset(x: 60, y: 75)
			}
			

			VStack(spacing: 3) {
				HStack {
					Text(product.name)
						.font(.system(size: 14, weight: .semibold, design: .default))
					Spacer()
					HStack(spacing: 2) {
						Image(systemName: "star.fill")
							.foregroundColor(.orange)
							.font(.system(size: 12))
						Text("10")
							.font(.system(size: 14))
					}
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
			}
			.padding(.leading, 8)
			.padding(.trailing, 8)
		}
		.padding(.leading, 15)
		.padding(.trailing, -5)
	}
}

#Preview {
	let product = Product(id: 32, picture: Product.Picture(url: "", description: ""), name: "test", likes: 10, price: 100, originalPrice: 110, category: .bottoms)
	CategoryItem(product: product)
}

extension CategoryItem {
	func asyncImage(from url: URL) -> some View {
		AsyncImage(url: url) { phase in
			switch phase {
			case .empty:
				ProgressView()
			case .success(let image):
				image
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 198, height: 198)
					.cornerRadius(16)
			case .failure:
				Image(systemName: "photo")
			@unknown default:
				EmptyView()
			}
		}
	}
}
