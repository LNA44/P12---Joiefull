//
//  JoiefullApp.swift
//  Joiefull
//
//  Created by Ordinateur elena on 29/07/2025.
//

import SwiftUI

@main
struct JoiefullApp: App {
    var body: some Scene {
        WindowGroup {
			let repository = JoiefullRepository()
			let homeViewModel = HomeViewModel(repository: repository)
			ContentView(viewModel: homeViewModel)
        }
    }
}
