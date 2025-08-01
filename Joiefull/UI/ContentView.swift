//
//  ContentView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 31/07/2025.
//

import SwiftUI

struct ContentView: View {
	@State private var selectedCategory: String?
	
	var body: some View {
		NavigationSplitView {
			HomeView()
		} detail: {
			if let selected = selectedCategory {
				Text("Détails pour \(selected)")
			} else {
				Text("Sélectionnez une catégorie")
					.foregroundColor(.gray)
			}
		}
		/*.onAppear {
			Task {
				await viewModel.fetchProducts()
			}
		}*/
	}
}

/*#Preview {
    ContentView()
}
*/
