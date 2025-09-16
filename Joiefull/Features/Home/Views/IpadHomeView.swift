//
//  IpadHomeView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 05/08/2025.
//

import SwiftUI

struct IpadHomeView: View {
	//MARK: -Public properties
	@ObservedObject var viewModel: HomeViewModel //recoit le VM du parent
	@ObservedObject var detailsViewModel: DetailsViewModel
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	var geometry: GeometryProxy
	
	//MARK: -Private properties
	@State private var selectedProduct: Product? = nil
	
	var body: some View {
		ZStack {
			Color("Background")
				.ignoresSafeArea()
			HStack(spacing: 0) {
				List {
					ForEach(viewModel.categories.keys.sorted(), id: \.self) { key in
						CategoryRow(categoryName: key, items: viewModel.categories[key] ?? [], selectedProduct: $selectedProduct, detailsViewModel: detailsViewModel)
							.listRowBackground(Color.clear)
					}
					.frame(height: 390)
					.listRowSeparator(.hidden)
					.listRowInsets(EdgeInsets())
				}
				.background(Color("Background"))
				.listStyle(PlainListStyle())
				.onAppear {
					Task {
						await viewModel.fetchProducts()
					}
				}
				.frame(width: selectedProduct == nil ? geometry.size.width : geometry.size.width * 0.6) // gauche 60%
				VStack(alignment: .trailing) {
					if let product = selectedProduct {
						DetailsView(product: product, detailsViewModel: detailsViewModel)
					} else {
						Text("Sélectionnez un produit")
					}
				}
				.frame(width: selectedProduct == nil ? geometry.size.width : geometry.size.width * 0.4) // droite 40%
			}
		}
	}
}

//MARK: -Preview
struct IpadHomeView_Previews: PreviewProvider {
	static var previews: some View {
		
		GeometryReader { geometry in
			let previewRepository = PreviewJoiefullRepository(productSet: .twoProducts)
			let previewViewModel = HomeViewModel(repository: previewRepository)
			IpadHomeView(viewModel: previewViewModel, detailsViewModel: DetailsViewModel(), geometry: geometry)
				.environmentObject(RatingsViewModel())
				.environmentObject(FavoriteViewModel())
		}
	}
}
