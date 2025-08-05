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
	@EnvironmentObject var ratingsVM: RatingsViewModel
	@State private var isImageFullscreen = false
	@State private var userRating: Double = 0 //State lance un rafraichissement de l'interface
	@State private var userComment: String = "" //modifie la vue à chaque nouvelle lettre tapée
	@State private var showShareSheet = false
	@State private var sharingComment: String = ""
	@State private var isUserFavorite: Bool = false
	@State private var localFavorites: Int
	
	@State private var imageSize: CGSize = .zero
	
	
	init(product: Product) {
		_viewModel = StateObject(wrappedValue: DetailsViewModel())
		self.product = product
		//self._note = note
		_localFavorites = State(initialValue: product.likes)
	}
	
	var body: some View {
		GeometryReader { geo in //pour adapter taille et dispo en fonction d'iphone ou ipad
			let imageWidth = geo.size.width * 0.9
			let imageHeight = geo.size.height * 0.55
			
			VStack {
				ZStack {
					HStack {
						if let url = product.picture.imageURL { //optionnel donc vérif pas nil
							AsyncImageView(url: url, width: imageWidth, height: imageHeight) //position adaptable iphone-ipad : 90% de la longueur et 60% de la largeur
								.background(
									GeometryReader { imageGeo in
										Color.clear
											.onAppear {
												imageSize = imageGeo.size
											}
									}
								)
								.onTapGesture {
									isImageFullscreen = true
								}
								.accessibilityLabel(product.picture.description)
								.accessibilityAddTraits(.isImage)
							
								.overlay(alignment: .bottomTrailing) {
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
									.padding(.trailing, imageWidth * 0.07)
									.padding(.bottom, imageHeight * 0.05)
									.accessibilityLabel("Le produit a été aimé par \(product.likes) d'utilisateurs")
								}
								.overlay(alignment: .topTrailing) {
									Button(action: {
										showShareSheet = true
									}) {
										Image("Share")
									}
									.padding(.top, imageWidth * 0.05)
									.padding(.trailing, imageHeight * 0.07)
									.accessibilityLabel("Partager ce produit")
									.accessibilityHint("Ouvre les options de partage")
									.sheet(isPresented: $showShareSheet) {
										ShareSheet(comment: sharingComment, productDescription: product.picture.description, isPresented: $showShareSheet)
									}
								}
						}
					}
				}
				.frame(width: imageWidth, height: imageHeight)
				
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
							Text(String(format: "%.1f", ratingsVM.getAverage(for: product.id)))
						}
					}
					.accessibilityElement()
					.accessibilityLabel("\(product.name) noté \(ratingsVM.getAverage(for: product.id)) étoiles")
					
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
						.onChange(of: userRating) { newValue in
							ratingsVM.addRating(rating: newValue, for: product.id)
						}
						.padding(.bottom, 5)
						.accessibilityLabel("Note de l'utilisateur de 1 à 5 étoiles")
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
}

/*#Preview {
	DetailsView(product: Product(id: 32, picture: Product.Picture(url: "https://raw.githubusercontent.com/LNA44/P12---Creez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg", description: "Description de la photo avec un sac à main orange"), name: "Sac orange", likes: 10, price: 100, originalPrice: 110, category: .bottoms))
}
*/
