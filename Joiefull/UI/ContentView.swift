//
//  ContentView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 31/07/2025.
//

import SwiftUI

struct ContentView: View {
	@StateObject var viewModel: HomeViewModel // state car vue doit garder l'état du VM même si la vue se recrée (on revient souvent sur cette vue après etre passé par une vue detail)
	@State private var selectedCategory: String?
	
	var body: some View {
		NavigationSplitView {
			HomeView(viewModel: viewModel)
		} detail: {
			if let selected = selectedCategory {
				Text("Détails pour \(selected)")
			} else {
				Text("Sélectionnez une catégorie")
					.foregroundColor(.gray)
			}
		}
		.onAppear {
			Task {
				await viewModel.fetchProducts()
			}
		}
	}
}

/*#Preview {
    ContentView(viewModel: <#T##HomeViewModel#>)
}
*/
