//
//  IphoneHomeView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 05/08/2025.
//

import SwiftUI

struct IphoneHomeView: View {
	@ObservedObject var viewModel: HomeViewModel

    var body: some View {
		List {
			ForEach(viewModel.categories.keys.sorted(), id: \.self) { key in
				CategoryRow(categoryName: key, items: viewModel.categories[key] ?? [])
				
					.padding(.bottom, -10)
					.padding(.top, -20)
			}
			.listRowSeparator(.hidden)
			.listRowInsets(EdgeInsets())
		}
		.listStyle(PlainListStyle())
		.padding(.top, 0)
		.scrollContentBackground(.hidden)
		.onAppear {
			Task {
				await viewModel.fetchProducts()
			}
		}
    }
}

#Preview {
	IphoneHomeView(viewModel: HomeViewModel(repository: JoiefullRepository()))
}
