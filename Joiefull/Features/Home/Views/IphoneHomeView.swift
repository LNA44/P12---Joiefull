//
//  IphoneHomeView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 05/08/2025.
//

import SwiftUI

struct IphoneHomeView: View {
	//MARK: -Public properties
	@ObservedObject var viewModel: HomeViewModel 
	@ObservedObject var detailsViewModel: DetailsViewModel
	
	//MARK: -Body
	var body: some View {
		List {
			ForEach(viewModel.categories.keys.sorted(), id: \.self) { key in
				CategoryRow(categoryName: key, items: viewModel.categories[key] ?? [], detailsViewModel: detailsViewModel)
				
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

	//MARK: -Preview
struct IphoneHomeView_Previews: PreviewProvider {
	static var previews: some View {
		GeometryReader { geometry in
			let previewRepository = PreviewJoiefullRepository(productSet: .twoProducts)
			let previewViewModel = HomeViewModel(repository: previewRepository)
			
			IphoneHomeView(viewModel: previewViewModel, detailsViewModel: DetailsViewModel())
				.environmentObject(RatingsViewModel())
				.environmentObject(FavoriteViewModel())
		}
	}
}
