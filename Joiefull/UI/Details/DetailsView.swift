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
	@StateObject var viewModel: DetailsViewModel
	@State private var isImageFullscreen = false
	@State private var userRating: Int = 0 //State lance un rafraichissement de l'interface
	@State private var userComment: String = "" //modifie la vue à chaque nouvelle lettre tapée
	@State private var showShareSheet = false
	@State private var sharingComment: String = ""
	private var ratingAverage: Double {
		viewModel.averageRating(productId: product.id)
	}
	@State private var isUserFavorite: Bool = false
	@State private var localFavorites: Int
	
	init(product: Product) {
		_viewModel = StateObject(wrappedValue: DetailsViewModel())
		self.product = product
		_localFavorites = State(initialValue: product.likes)
	}
	
    var body: some View {
		VStack {
			ZStack {
				HStack {
					if let url = product.picture.imageURL { //optionnel donc vérif pas nil
						AsyncImageView(url: url, width: 370, height: 405)
							.onTapGesture {
								isImageFullscreen = true
							}
							.accessibilityElement()
							.accessibilityLabel("\(product.picture.description)")
					}
				}
				ZStack {
					Button (action: {
						if isUserFavorite {
							localFavorites -= 1
						} else {
							localFavorites += 1
						}
						isUserFavorite.toggle()
					}) {
						RoundedRectangle(cornerRadius: 20)
							.fill(Color.white)
							.frame(width:CGFloat(89), height:CGFloat(45))
							.overlay(
								HStack(spacing: 5) {
									Image(systemName: isUserFavorite ? "heart.fill" : "heart")
										.frame(width: 22)
										.foregroundColor(.black)
									
									Text("\(localFavorites)")
										.font(.system(size: 21, weight: .semibold))
										.foregroundColor(.black)
								}
							)
					}
					.offset(x:120, y: 160)
				}
				.accessibilityElement()
				.accessibilityLabel("Le produit a été aimé par \(product.likes) d'utilisateurs")

				Button(action: {
					showShareSheet = true
				}) {
					Image("Share")
				}
				.position(x: 360, y: 40)
				.sheet(isPresented: $showShareSheet) {
					ShareSheet(comment: sharingComment, productDescription: product.picture.description, isPresented: $showShareSheet)
				}
			}
			
			HStack {
				HStack {
					Text("\(product.name)")
						.font(.system(size: 22, weight: .semibold, design: .default))
						.accessibilityHidden(true)
					Spacer()
					HStack(spacing: 2) {
						Image(systemName: "star.fill")
							.foregroundColor(.orange)
							.font(.system(size: 23))
						Text(String(format: "%.1f", ratingAverage))
							.font(.system(size: 22))
					}
				}
				.accessibilityElement()
				.accessibilityLabel("\(product.name) noté \(ratingAverage) étoiles")
				
			}
			.padding(.top, 20)
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
			.padding(.bottom, 20)
			.padding(.horizontal, 20)
			.accessibilityElement()
			.accessibilityLabel("Prix : \(Int(product.price)), prix d'origine : \(Int(product.originalPrice))")

			HStack {
				Text("\(product.picture.description)")
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.top, 5)
			}
			.padding(.horizontal, 20)
			.padding(.bottom, 15)
			
			HStack (spacing: 20){
				Image("Mask group")
					.accessibilityLabel("Image de profil utilisateur")
				StarRatingView(rating: $userRating)
					.padding(.bottom, 5)
					.accessibilityLabel("Note de l'utilisateur de 1 à 5 étoiles")
					.onChange(of: userRating) { newValue in
						if newValue > 0 {
							viewModel.addRating(productId: product.id, rating: newValue)
						}
					}
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
					.accessibilityLabel("Partagez ici vos impressions sur cette pièce")
				}
			.padding(.horizontal, 20)
			.padding(.top, 15)
		}
		.sheet(isPresented: $isImageFullscreen) {
			FullscreenImageView(imageURL: product.picture.imageURL)
				.accessibilityLabel("Image en plein écran")
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

/*#Preview {
	DetailsView(product: Product(id: 32, picture: Product.Picture(url: "https://raw.githubusercontent.com/LNA44/P12---Creez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg", description: "Description de la photo avec un sac à main orange"), name: "Sac orange", likes: 10, price: 100, originalPrice: 110, category: .bottoms))
}
*/
