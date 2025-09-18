//
//  LaunchView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 30/07/2025.
//

import SwiftUI

struct LaunchView: View {
	//MARK: -Public properties
	@Environment(\.colorScheme) var colorScheme
	
	//MARK: -Body
	var body: some View {
		VStack {
			Spacer()
			
			Image("logo")
				.resizable()
				.scaledToFit()
				.frame(width: 150, height: 150)
				.accessibilityHidden(true)
			
			Spacer()
			
			ProgressView()
				.padding(.bottom, 40)
				.accessibilityLabel("Chargement en cours")
			
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color("MainColor"))
	}
}

	//MARK: -Preview
#Preview {
	LaunchView()
}
