//
//  DetailsView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 30/07/2025.
//

import SwiftUI

struct DetailsView: View {
	//MARK: -Public properties
	var product: Product
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	@Environment(\.colorScheme) var colorScheme //définit les couleurs pour modes clair et sombre
	@EnvironmentObject var ratingsVM: RatingsViewModel
	@EnvironmentObject var favoriteVM: FavoriteViewModel
	@ObservedObject var detailsViewModel: DetailsViewModel
	
	//MARK: -Private properties
	@Environment(\.dismiss) private var dismiss  // Pour fermer la vue
	@State private var isImageFullscreen = false
	@State private var userComment: String = "" //modifie la vue à chaque nouvelle lettre tapée
	@State private var showShareSheet = false
	@State private var sharingComment: String = ""
	@State private var imageSize: CGSize = .zero
	@FocusState private var isCommentFocused: Bool
	
	//MARK: -Initialization
	init(product: Product, detailsViewModel: DetailsViewModel) {
		self.product = product
		self.detailsViewModel = detailsViewModel
	}
	
	//MARK: -Body
	var body: some View {
		GeometryReader { geo in //pour adapter taille et dispo en fonction de taille écran iphone ou ipad
			let imageWidth = geo.size.width * 0.9
			let imageHeight = geo.size.height * 0.55
			ScrollView {
				VStack {
					sectionImageProduit(imageWidth: imageWidth, imageHeight: imageHeight)
					HStack {
						sectionTitreEtNote
					}
					.padding(.top, horizontalSizeClass == .compact ? 20 : 15)
					.padding(.horizontal, 20)
					.padding(.bottom, 2)
					
					sectionPrix
					sectionDescription
					sectionNotationUtilisateur
					sectionCommentaire
				}
				.sheet(isPresented: $isImageFullscreen) {
					FullscreenImageView(imageURL: product.picture.imageURL)
						.accessibilityLabel("Image en plein écran")
				}
				.navigationBarBackButtonHidden(true)  // Cache le bouton retour natif
				.navigationBarHidden(horizontalSizeClass == .regular)
				.toolbar {
					if horizontalSizeClass == .compact {
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
			.onAppear {
				favoriteVM.setInitialLikes(for: product.id, count: product.likes) //nombre de likes au départ = ceux reçu par l'API
			}
			.onTapGesture { // quand on tape en dehors du TextEditor le clavier est retiré
				isCommentFocused = false
			}
		}
	}
	
	// MARK: -Sections
	private func sectionImageProduit(imageWidth: CGFloat, imageHeight: CGFloat) -> some View {
		ZStack {
			HStack {
				if let url = product.picture.imageURL { //optionnel donc vérif pas nil
					AsyncImageView(url: url, width: imageWidth, height: imageHeight) //position adaptable iphone-ipad : 90% de la longueur et 55% de la largeur
						.background(
							GeometryReader { imageGeo in
								Color.clear
									.onAppear {
										imageSize = imageGeo.size
									}
							}
						)
					
						.onTapGesture {
							if !isCommentFocused {
								isImageFullscreen = true
							}
						}
						.accessibilityLabel(product.picture.description)
						.accessibilityHint("Afficher en plein écran")
						.accessibilityAddTraits(.isImage)
					
						.overlay(alignment: .bottomTrailing) {
							boutonFavori(imageWidth: imageWidth, imageHeight: imageHeight)
								.padding(.trailing, imageWidth * 0.05)
								.padding(.bottom, imageHeight * 0.04)
								.accessibilityElement()
								.accessibilityAddTraits(.isButton)
								.accessibilityLabel("Le produit a été aimé par \(product.likes) d'utilisateurs")
						}
						.overlay(alignment: .topTrailing) {
							boutonPartager(imageWidth: imageWidth, imageHeight: imageHeight)
						}
				}
			}
		}
		.frame(width: imageWidth, height: imageHeight)
	}
	
	private func boutonFavori(imageWidth: CGFloat, imageHeight: CGFloat) -> some View {
		Button (action: {
			favoriteVM.toggleFavorite(for: product.id)
			
			DispatchQueue.main.async { //annonce du changement de statut par VoiceOver
				UIAccessibility.post(
					notification: .announcement,
					argument: favoriteVM.isFavorite(product.id) ? "Ajouté aux favoris" : "Retiré des favoris"
				)
			}
		}) {
			RoundedRectangle(cornerRadius: 20)
				.fill(Color.white)
				.frame(
					width: horizontalSizeClass == .compact ? 78 : 89,
					height: horizontalSizeClass == .compact ? 44 : 45
				)
				.overlay(
					HStack(spacing: 5) {
						Image(systemName: favoriteVM.isFavorite(product.id) ? "heart.fill" : "heart")
							.frame(width: 22)
							.foregroundColor(.black)
						
						Text("\(favoriteVM.likesCount(for: product.id))")
							.font(.system(
								size: horizontalSizeClass == .compact ? 18 : 21,
								weight: .semibold
							))
							.foregroundColor(.black)
					}
				)
			
		}
		.accessibilitySortPriority(2)
		.accessibilityLabel("Favori")
		.accessibilityValue(favoriteVM.isFavorite(product.id) ? "Activé" : "Désactivé")
		.accessibilityHint(favoriteVM.isFavorite(product.id) ? "Retirer des favoris" : "Ajouter aux favoris")
	}
	
	private func boutonPartager(imageWidth: CGFloat, imageHeight: CGFloat) -> some View {
		Button(action: {
			showShareSheet = true
		}) {
			Image("Share")
		}
		.padding(.top, imageWidth * 0.05)
		.padding(.trailing, imageHeight * 0.06)
		.accessibilitySortPriority(1)
		.accessibilityLabel("Partager")
		.accessibilityHint("Ouvrir les options de partage")
		.sheet(isPresented: $showShareSheet, onDismiss: {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
				UIAccessibility.post(
					notification: .announcement,
					argument: "Produit partagé"
				)
			}
		}) {
			ShareSheet(productImageURL: product.picture.url, defaultComment: "Regarde ce produit !", isPresented: $showShareSheet)
		}
	}
	
	private var sectionTitreEtNote: some View {
		HStack {
			Text("\(product.name)")
				.font(.system(size: 22, weight: .semibold, design: .default))
			Spacer()
			HStack(spacing: 2) {
				Image(systemName: "star.fill")
					.foregroundColor(.orange)
					.font(.system(size: 23))
				Text(String(format: "%.1f", ratingsVM.getAverage(for: product.id)))
					.font(.system(size: 22, weight: .semibold))
			}
		}
		.accessibilityElement()
		.accessibilitySortPriority(4)
		.accessibilityLabel("\(product.name) noté \(String(format: "%.1f", ratingsVM.getAverage(for: product.id))) étoiles")
	}
	
	private var sectionPrix: some View {
		HStack {
			Text("\(String(format: "%.0f", product.price))€") //arrondi 0 chiffres après la virgule
				.font(.system(size: 22))
			
			Spacer()
			Text(String("\(String(format: "%.0f", product.originalPrice))€"))
				.strikethrough(true, color: colorScheme == .dark ? Color.white : Color.black.opacity(0.8))
				.font(.system(size: 22))
				.foregroundColor(colorScheme == .dark ? Color.white : Color.black.opacity(0.8))
			
		}
		.padding(.horizontal, 20)
		.accessibilityElement()
		.accessibilitySortPriority(3)
		.accessibilityLabel("Prix réduit : \(String(format: "%.0f", product.price)) euros; prix d'origine : \(String(format: "%.0f", product.originalPrice)) euros")
	}
	
	private var sectionDescription: some View {
		HStack {
			Text("\(product.picture.description)")
				.font(.system(size: 18))
				.lineLimit(nil)         // autorise autant de lignes que nécessaire
				.fixedSize(horizontal: false, vertical: true) // permet au texte de s'étendre verticalement
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.top, 5)
				.accessibilityLabel("Description du produit : \(product.picture.description)")
		}
		.padding(.horizontal, 20)
		.padding(.bottom, 20)
	}
	
	private var sectionNotationUtilisateur: some View {
		HStack (spacing: 20){
			Image("Mask group")
				.accessibilityLabel("Image de profil utilisateur")
			StarRatingView(rating: Binding(
				get: { //récupérer la note utilisateur pour l'afficher en étoiles pleines
					ratingsVM.getUserRating(for: product.id)
				},
				set: { newRating in //quand utilisateur modifie la note elle est ajoutée
					ratingsVM.addRating(rating: newRating, for: product.id)
				}
			))
			.padding(.bottom, 5)
			.accessibilityElement(children: .ignore)
			.accessibilityLabel("Note")
			.accessibilityValue(String(format: "%.1f sur 5", ratingsVM.getUserRating(for: product.id)))
			
			Spacer()
		}
		.padding(.horizontal, 20)
	}
	
	private var sectionCommentaire: some View {

		VStack {
			ZStack(alignment: .topLeading) {
				TextEditor(text: $userComment)
					.focused($isCommentFocused)
					.scrollContentBackground(.hidden)
					.background(
						horizontalSizeClass == .compact
						? Color.clear
						: Color("Background")
					)
					.padding(.horizontal, 10)
					.padding(.top, 8)
					.frame(height: horizontalSizeClass == .compact ? 150 : 60)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color.gray.opacity(0.5), lineWidth: 1)
							.background(Color.clear)
					)
					.accessibilityLabel("Commentaire")
					.accessibilityHint("Saisir un commentaire à partager")
				if userComment.isEmpty {
					Text("Partagez ici vos impressions sur cette pièce")
						.foregroundColor(.gray)
						.background(
							horizontalSizeClass == .compact
							? Color.clear
							: Color("Background")
						)
						.font(.system(size: 14))
						.padding(.horizontal, 14)
						.padding(.top, 12)
				}
			}
			.padding(.top, 15)

			Button("Publier") {
				guard !userComment.isEmpty else { return }
				detailsViewModel.addComment(for: product.id, author: "Marion", text: userComment)
				userComment = ""
			}
			.padding()
			.frame(maxWidth: .infinity)
			.background(Color.gray)
			.foregroundColor(.white)
			.cornerRadius(8)
			
			sectionLikesUtilisateur
			
			VStack {
				let comments = detailsViewModel.commentsByProduct[product.id] ?? []
				if comments.isEmpty {
					Text("Aucun commentaire partagé pour l'instant")
						.foregroundColor(.gray)
						.padding()
				} else {
					ScrollView {
						LazyVStack(alignment: .leading, spacing: 10) {
							ForEach(comments) { comment in
								VStack(alignment: .leading) {
									Text(comment.author)
										.font(.headline)
									Text(comment.text)
									Text(comment.date, style: .date)
										.font(.caption)
										.foregroundColor(.gray)
								}
								.padding(.vertical, 5)
							}
						}
						.padding(.horizontal, 20)
					}
					.frame(maxHeight: 300) // tu peux ajuster la hauteur
				}
			}
		}
		.padding(.horizontal, 20)
		.toolbar {
			ToolbarItemGroup(placement: .keyboard) { //ajoute un bouton pour replier le clavier
				Button {
					isCommentFocused = false
				} label: {
					Label("Replier le clavier", systemImage: "keyboard.chevron.compact.down")
				}
				Spacer()
				Button("Terminé") { isCommentFocused = false }
			}
		}
	}
	
	private var sectionLikesUtilisateur: some View {
		HStack {
			RoundedRectangle(cornerRadius: 20)
				.fill(
						horizontalSizeClass == .regular
						? Color.white
						: (colorScheme == .dark ? Color.white : Color.gray.opacity(0.2))
					)
				.frame(width:CGFloat(77), height:CGFloat(37))
				.overlay(
					HStack(spacing: 5) {
						Image(systemName: "heart")
							.frame(width: 18)
							.foregroundColor(.black)
						
						Text("\(favoriteVM.userLikesCount())")
							.font(.system(size: 18, weight: .semibold))
							.foregroundColor(.black)
					}
				)
			Spacer()
		}
		.padding(.leading, 50)
		.padding(.top, 10)
		.accessibilityLabel("Nombre de mentions J’aime")
		.accessibilityValue("\(favoriteVM.userLikesCount())")
	}
}

//MARK: -Preview
struct DetailsView_Previews: PreviewProvider {
	static let fakeProduct = Product(
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
	
	static let ratingsVM: RatingsViewModel = {
		let vm = RatingsViewModel()
		vm.addRating(rating: 4.5, for: fakeProduct.id)
		return vm
	}()
	
	static let favoriteVM = FavoriteViewModel()
	
	static let viewModel = DetailsViewModel()
	static var previews: some View {
		NavigationStack { //utile pour afficher bouton retour, vérifier que navigationbar cachée,...
			DetailsView(product: fakeProduct, detailsViewModel:viewModel)
				.environmentObject(ratingsVM)
				.environmentObject(favoriteVM)
		}
	}
}
