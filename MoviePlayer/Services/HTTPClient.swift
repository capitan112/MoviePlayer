//
//  HTTPClient.swift
//  MoviePlayer
//
//  Created by Oleksiy Chebotarov on 17/06/2024.
//

import Combine
import Foundation

protocol HTTPClientProtocol {
    static var shared: HTTPClient { get }
    func fetchMovies(url: URL) -> AnyPublisher<[Movie], Error>
}

class HTTPClient: HTTPClientProtocol {
    static let shared = HTTPClient()
    private init() {}

    func fetchMovies(url: URL) -> AnyPublisher<[Movie], Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.categories.flatMap { $0.videos } }
            .eraseToAnyPublisher()
    }
}

struct MovieResponse: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let name: String
    let videos: [Movie]
}
