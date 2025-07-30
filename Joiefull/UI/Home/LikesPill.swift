//
//  LikesPill.swift
//  Joiefull
//
//  Created by Ordinateur elena on 30/07/2025.
//

import SwiftUI

struct LikesPill: View {
	let product: Product
    var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 20)
				.fill(Color.white)
				.frame(width:51, height:27)
			
			HStack(spacing: 5) {
				Image(systemName: "heart")
					.frame(width: 14)
				
				Text("\(product.likes)")
					.font(.system(size: 14, weight: .semibold, design: .default))
					.foregroundColor(.black)
			}
		}
	}
}

#Preview {
	LikesPill(product: Product(id: 1, picture: Product.Picture(url: "", description: ""), name: "test", likes: 10, price: 100, originalPrice: 110, category: .bottoms))
}
