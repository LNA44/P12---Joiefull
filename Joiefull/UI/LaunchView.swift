//
//  LaunchView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 30/07/2025.
//

import SwiftUI

struct LaunchView: View {
	@State private var isActive = false
	let repository: JoiefullRepository
	
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
				
				Spacer()
				
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle())
					.padding(.bottom, 40)
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
