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
	
	init() {
		let repository = JoiefullRepository()
		_viewModel = StateObject(wrappedValue: HomeViewModel(repository: repository))
	}
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(viewModel.categories.keys.sorted(), id: \.self) { key in
					CategoryRow(categoryName: key, items: viewModel.categories[key] ?? [])
						
						.padding(.bottom, -10)
						.padding(.top, -20)
				}
				.listRowSeparator(.hidden)
				.listRowInsets(EdgeInsets())
			}
			.padding(.top, -45)
			.padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 50 : 0)
			.scrollContentBackground(.hidden)
			.onAppear {
				Task {
					await viewModel.fetchProducts()
				}
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
