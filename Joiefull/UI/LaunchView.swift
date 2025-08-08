//
//  LaunchView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 30/07/2025.
//

import SwiftUI

struct LaunchView: View {
	//MARK: -Public properties
	@State private var isActive = false
	
	//MARK: -Body
	var body: some View {
		if isActive {
			HomeView()
		} else {
			VStack {
				Spacer()
				
				Image("logo") 
					.resizable()
					.scaledToFit()
					.frame(width: 150, height: 150)
					.accessibilityHidden(true)
				
				Spacer()
				
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle())
					.padding(.bottom, 40)
					.accessibilityLabel("Chargement en cours")
				
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(Color("MainColor"))
			.onAppear {
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					withAnimation {
						isActive = true
					}
				}
			}
		}
	}
}

/*#Preview {
    LaunchView()
}*/
