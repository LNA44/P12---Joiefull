//
//  ContentView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import SwiftUI

struct HomeView: View {
	@StateObject var viewModel: HomeViewModel // state car vue doit garder l'état du VM même si la vue se recrée (on revient souvent sur cette vue après etre passé par une vue detail)
	
	init(viewModel: HomeViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	var body: some View {
		NavigationSplitView {
			List {
				ForEach(viewModel.categories.keys.sorted(), id: \.self) { key in // car dico = [clé: valeur]
					CategoryRow(categoryName: key, items: viewModel.categories[key] ?? [])
						.padding(.bottom, -10)
						.padding(.top, -20)
				}
				.listRowSeparator(.hidden)
				.listRowInsets(EdgeInsets())
			}
			.padding(.top, -45)   
			.scrollContentBackground(.hidden) // Cache le fond de la liste par défaut
		} detail: {
			Text("Hello, World!")
		}
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
