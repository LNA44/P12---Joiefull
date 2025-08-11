//
//  RemoteImageView.swift
//  Joiefull
//
//  Created by Ordinateur elena on 31/07/2025.
//

import SwiftUI

struct AsyncImageView: View {
	//MARK: -Public properties
	let url: URL
	var width: CGFloat
	var height: CGFloat
	
	//MARK: -Body
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

//MARK: -Preview
#Preview {
	AsyncImageView(url: URL(string: "https://raw.githubusercontent.com/LNA44/P12---Creez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg")!, width: CGFloat(215), height: CGFloat( 215))
}
