//
//  ContentView.swift
//  MoviePlayer
//
//  Created by Oleksiy Chebotarov on 17/06/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = MovieViewModel()

    var body: some View {
        NavigationView {
            if viewModel.movies.count > 0 {
                List(viewModel.movies) { movie in
                    Button(action: {
                        viewModel.selectMovie(movie: movie)
                    }) {
                        MovieCell(movie: movie)
                    }
                }
                .navigationTitle("Movies")
                .sheet(item: $viewModel.selectedMovie) { movie in
                    MoviePlayerView(url: movie.url)
                }
            } else {
                ContentUnavailableView {
                    Label("No movies in current time", systemImage: "movieclapper")
                } description: {
                    Text("Try to search it later")
                }
            }
        }
        .refreshable {
            viewModel.loadMovies()
        }
    }
}

#Preview {
    ContentView()
}
