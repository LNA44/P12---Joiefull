//
//  FullScreenImageView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 31/07/2025.
//

import SwiftUI

struct FullscreenImageView: View {
	//MARK: -Public properties
	var imageURL: URL?
	@Environment(\.dismiss) var dismiss // fermer une vue présentée depuis la vue elle-même (sheet)
	
	//MARK: -Body
	var body: some View {
		ZStack(alignment: .topTrailing) {
			Color.black.ignoresSafeArea()
			
			if let imageURL = imageURL {
				AsyncImage(url: imageURL) { image in
					image
						.resizable()
						.scaledToFit()
						.frame(maxWidth: .infinity, maxHeight: .infinity)
				} placeholder: {
					ProgressView()
				}
			}
			
			Button(action: {
				dismiss()
			}) {
				Image(systemName: "xmark.circle.fill")
					.font(.system(size: 30))
					.foregroundColor(.white)
					.padding()
			}
		}
	}
}

	//MARK: -Preview
#Preview {
	FullscreenImageView(imageURL: URL(string: "https://raw.githubusercontent.com/LNA44/P12---Creez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg"))
}
