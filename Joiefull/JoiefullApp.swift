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
	
	var body: some Scene {
		WindowGroup {
			if showLaunchView {
				LaunchView()
					.onAppear {
						// Simuler un délai de lancement, puis passer à ContentView
						DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
							withAnimation {
								showLaunchView = false
							}
						}
					}
			} else {
				HomeView()
			}
		}
	}
}
