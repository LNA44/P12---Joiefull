//
//  ContentView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import SwiftUI

struct HomeView: View {
	//MARK: -Public properties
	@StateObject var viewModel: HomeViewModel
	@StateObject var ratingsVM = RatingsViewModel()
	@StateObject var favoriteVM = FavoriteViewModel()
	@StateObject var detailsVM = DetailsViewModel()
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	@AccessibilityFocusState private var isFocused: Bool
	
	//MARK: -Initialization
	init(viewModel: HomeViewModel? = nil) {
		if let viewModel {
			_viewModel = StateObject(wrappedValue: viewModel)
		} else {
			let repository = JoiefullRepository()
			_viewModel = StateObject(wrappedValue: HomeViewModel(repository: repository))
		}
	}
	
	//MARK: -Body
	var body: some View {
		NavigationStack {
			// iPad : Vue splitée
			if horizontalSizeClass == .regular {
				GeometryReader { geometry in
					IpadHomeView(viewModel: viewModel, detailsViewModel: detailsVM, geometry: geometry)
						.accessibilityFocused($isFocused)
						.accessibilityLabel("Accueil iPad, liste des produits")
				}
			} else {
				// iPhone : navigation vers la vue de détail
				IphoneHomeView(viewModel: viewModel, detailsViewModel: detailsVM)
					.accessibilityFocused($isFocused)
					.accessibilityLabel("Accueil iPhone, liste des produits")
			}
		}
		.environmentObject(ratingsVM)
		.environmentObject(favoriteVM)
		.alert(isPresented: $viewModel.showAlert) {
			Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
		}
		.onAppear {
			Task {
				await viewModel.fetchProducts()
			}
		}
	}
}

//MARK: -Preview
struct HomeView_Previews: PreviewProvider {
	
	static var previews: some View {
		Group {
			// iPhone
			HomeView(viewModel: HomeViewModel(repository: PreviewJoiefullRepository(productSet: .twoProducts)))
				.previewDisplayName("iPhone")
			
			// iPad
			HomeView(viewModel: HomeViewModel(repository: PreviewJoiefullRepository(productSet: .twoProducts)))
				.previewDisplayName("iPad")
		}
	}
}
