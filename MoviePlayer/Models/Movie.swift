//
//  Movie.swift
//  MoviePlayer
//
//  Created by Oleksiy Chebotarov on 17/06/2024.
//

import Foundation

struct Movie: Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: String
    let subtitle: String
    let sources: [String]
    let thumb: String
    
    enum CodingKeys: CodingKey {
        case title, description, subtitle, sources, thumb
    }
    
    var url: URL {
        return URL(string: sources.first!)!
    }

    var imageUrl: URL {
        return URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/\(thumb)")!
    }
}
