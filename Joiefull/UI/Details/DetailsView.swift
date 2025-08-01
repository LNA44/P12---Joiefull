//
//  DetailsView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 30/07/2025.
//

import SwiftUI

struct DetailsView: View {
	var product: Product
	@Environment(\.dismiss) private var dismiss  // Pour fermer la vue
	@State private var isImageFullscreen = false
	@State private var userRating: Int = 0 //State lance un rafraichissement de l'interface
	@State private var userComment: String = "" //modifie la vue à chaque nouvelle lettre tapée
	
    var body: some View {
		VStack {
			ZStack {
				HStack {
					if let url = product.picture.imageURL { //optionnel donc vérif pas nil
						AsyncImageView(url: url, width: 370, height: 405)
							.onTapGesture {
								isImageFullscreen = true
							}
					}
				}
				LikesPill(product: product, containerWidth: 89, containerHeight: 45, textSize: 22, heartSize: 21)
					.offset(x: 125, y: 160)
			}
			
			HStack {
				HStack {
					Text("\(product.name)")
						.font(.system(size: 22, weight: .semibold, design: .default))
					Spacer()
					HStack(spacing: 2) {
						Image(systemName: "star.fill")
							.foregroundColor(.orange)
							.font(.system(size: 23))
						Text("10")
							.font(.system(size: 22))
					}
				}
				
			}
			.padding(.horizontal, 20)
			
			HStack {
				Text("\(String(format: "%.0f", product.price))€") //arrondi 0 chiffres aprèsla virgule
						.font(.system(size: 22))
				
				Spacer()
				Text(String("\(String(format: "%.0f", product.originalPrice))€"))
					.strikethrough(true, color: Color.black.opacity(0.8))
					.font(.system(size: 22))
					.foregroundColor(Color.black.opacity(0.8))
			}
			.padding(.horizontal, 20)

			HStack {
				Text("\(product.picture.description)")
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.top, 5)
			}
			.padding(.horizontal, 20)
			.padding(.bottom, 15)
			
			HStack (spacing: 20){
				Image("Mask group")
				StarRatingView(rating: $userRating)
					.padding(.bottom, 5)
				Spacer()
			}
			.padding(.horizontal, 20)
			
			HStack {
				TextField("Partagez ici vos impressions sur cette pièce", text: $userComment)
					.frame(height: 60)
					.padding(.horizontal, 10)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color.gray.opacity(0.5), lineWidth: 1)
					)
				}
			.padding(.horizontal, 20)
			.padding(.top, 15)
		}
		.sheet(isPresented: $isImageFullscreen) {
			FullscreenImageView(imageURL: product.picture.imageURL)
		}
		.navigationBarBackButtonHidden(true)  // Cache le bouton retour natif
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button(action: {
					dismiss()  
				}) {
					HStack {
						Image(systemName: "chevron.left")
						Text("Home")
					}
				}
			}
		}
	}
}

#Preview {
	DetailsView(product: Product(id: 32, picture: Product.Picture(url: "https://raw.githubusercontent.com/LNA44/P12---Creez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg", description: "Description de la photo avec un sac à main orange"), name: "Sac orange", likes: 10, price: 100, originalPrice: 110, category: .bottoms))
}
