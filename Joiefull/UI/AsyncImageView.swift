//
//  RemoteImageView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 31/07/2025.
//

import SwiftUI

struct AsyncImageView: View {
	let url: URL
	var width: CGFloat = 198
	var height: CGFloat = 198
	
	var body: some View {
		AsyncImage(url: url) { phase in
			switch phase {
			case .empty:
				ProgressView()
			case .success(let image):
				image
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: width, height: height)
					.cornerRadius(16)
			case .failure:
				Image(systemName: "photo")
					.accessibilityLabel("Image non disponible")
			@unknown default:
				EmptyView()
			}
		}
	}
}

#Preview {
	AsyncImageView(url: URL(string: "https://raw.githubusercontent.com/LNA44/P12---Creez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg")!)
}
