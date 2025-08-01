//
//  LikesPill.swift
//  Joiefull
//
//  Created by Ordinateur elena on 30/07/2025.
//

import SwiftUI

struct LikesPill: View {
	var product: Product
	var containerWidth = 51
	var containerHeight = 27
	var textSize = 14
	var heartSize = 14
    var body: some View {
		ZStack {
			Button (action: {
			}) {
				RoundedRectangle(cornerRadius: 20)
					.fill(Color.white)
					.frame(width:CGFloat(containerWidth), height:CGFloat(containerHeight))
				
				HStack(spacing: 5) {
					Image(systemName: "heart")
						.frame(width: CGFloat(heartSize))
					
					Text("\(product.likes)")
						.font(.system(size: CGFloat(textSize), weight: .semibold, design: .default))
						.foregroundColor(.black)
				}
			}
			
		}
		.accessibilityElement()
		.accessibilityLabel("Le produit a été aimé par \(product.likes) d'utilisateurs")
	}
}

#Preview {
	LikesPill(product: Product(id: 1, picture: Product.Picture(url: "", description: ""), name: "test", likes: 10, price: 100, originalPrice: 110, category: .bottoms))
}
