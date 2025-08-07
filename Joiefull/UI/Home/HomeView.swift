//
//  ContentView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import SwiftUI

struct HomeView: View {
	@StateObject var viewModel: HomeViewModel
	@StateObject var ratingsVM = RatingsViewModel()
	@StateObject var favoriteVM = FavoriteViewModel()
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	
	init() {
		let repository = JoiefullRepository()
		_viewModel = StateObject(wrappedValue: HomeViewModel(repository: repository))
	}
	
	var body: some View {
		NavigationStack {
			// iPad : Split View
			if horizontalSizeClass == .regular {
				GeometryReader { geometry in
					IpadHomeView(viewModel: viewModel, geometry: geometry)
				}				
			} else {
				// iPhone : navigation vers la vue de détail
				IphoneHomeView(viewModel: viewModel)
			}
		}
		.environmentObject(ratingsVM)
		.environmentObject(favoriteVM)
		.onAppear {
			Task {
				await viewModel.fetchProducts()
			}
		}
	}
}

//créer mock
/*struct HomeView_Preview: PreviewProvider {
 static var previews: some View {
 let repository = JoiefullRepository()
 let vm = HomeViewModel(repository: repository)
 return HomeView(viewModel: vm)
	}
}*/
