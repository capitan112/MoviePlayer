//
//  MovieCell.swift
//  MoviePlayer
//
//  Created by Oleksiy Chebotarov on 17/06/2024.
//

import SwiftUI

struct MovieCell: View {
    let movie: Movie

    var body: some View {
        HStack {
            ResizableImage(imageUrl: movie.imageUrl)
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(movie.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text(movie.description)
                    .font(.body)
                    .foregroundColor(.black)
                    .lineLimit(3)
            }
            .padding(.leading, 8)
        }
    }
}
