import SwiftUI
import Combine

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let type: String
    let imdbID: String?
    let tmdbID: Int?
    let tmdbType: String?
    let seasonNumber: Int?
    let posterURL: String?
    let sourceReleaseDate: String?
    let sourceName: String?
    let isOriginal: Int

    enum CodingKeys: String, CodingKey {
        case id, title, type
        case imdbID = "imdb_id"
        case tmdbID = "tmdb_id"
        case tmdbType = "tmdb_type"
        case seasonNumber = "season_number"
        case posterURL = "poster_url"
        case sourceReleaseDate = "source_release_date"
        case sourceName = "source_name"
        case isOriginal = "is_original"
    }
}



import Foundation

struct Season: Identifiable, Codable {
    let id: Int
    let posterURL: String
    let name: String
    let overview: String
    let number: Int
    let airDate: String
    let episodeCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case posterURL = "poster_url"
        case name, overview, number
        case airDate = "air_date"
        case episodeCount = "episode_count"
    }
}
