//
//  MovieViewMode.swift
//  MoviePlayer
//
//  Created by Oleksiy Chebotarov on 17/06/2024.
//
import Combine
import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var selectedMovie: Movie?
    private var cancellables = Set<AnyCancellable>()
    private var httpClient: HTTPClientProtocol

    private let url = URL(string: "https://gist.githubusercontent.com/capitan112/19f26e847de3ea88addfb752cf58249a/raw/18ce62ad0b634a5af87b04a8020cfd47caf4c3bd/gistfile1.txt")!
    
    init() {
        self.httpClient = HTTPClient.shared
        loadMovies()
    }

    func loadMovies() {
        self.httpClient.fetchMovies(url: self.url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    debugPrint("Error fetching movies: \(error)")
                }
            }, receiveValue: { movies in
                self.movies = movies
            })
            .store(in: &cancellables)
    }

    func selectMovie(movie: Movie) {
        selectedMovie = movie
    }
}
