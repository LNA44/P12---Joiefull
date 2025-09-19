//
//  JoiefullApp.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import SwiftUI

@main
struct JoiefullApp: App {
	@State private var showLaunchView = true
	@StateObject var ratingsVM = RatingsViewModel()
	@StateObject var favoriteVM = FavoriteViewModel()
	@StateObject var detailsVM = DetailsViewModel()
	
	var body: some Scene {
		WindowGroup {
			if showLaunchView {
				LaunchView()
					.onAppear {
						DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
							withAnimation {
								showLaunchView = false
							}
						}
					}
			} else {
				HomeView(detailsVM: detailsVM)
					.environmentObject(ratingsVM)
					.environmentObject(favoriteVM)
			}
		}
	}
}
