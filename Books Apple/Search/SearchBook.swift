//
//  SearchBook.swift
//  Books Apple
//
//  Created by Abdallah on 12/1/21.
//

import Foundation
// MARK: - SearchBook
struct SearchBook: Codable {
    let resultCount: Int?
    let results: [ResultSearch]?

    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case results = "results"
    }
}

// MARK: - Result
struct ResultSearch: Codable {
    let artworkUrl60: String?
    let artworkUrl100: String?
    let artistViewUrl: String?
    let trackCensoredName: String?
    let fileSizeBytes: Int?
    let formattedPrice: String?
    let trackViewUrl: String?
    let artistIds: [Int]?
    let releaseDate: String?
    let trackId: Int?
    let trackName: String?
    let genreIds: [String]?
    let currency: String?
    let kind: String?
    let artistId: Int?
    let artistName: String?
    let genres: [String]?
    let price: Double?
    let resultDescription: String?
    let userRatingCount: Int?
    let averageUserRating: Double?

    enum CodingKeys: String, CodingKey {
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl100 = "artworkUrl100"
        case artistViewUrl = "artistViewUrl"
        case trackCensoredName = "trackCensoredName"
        case fileSizeBytes = "fileSizeBytes"
        case formattedPrice = "formattedPrice"
        case trackViewUrl = "trackViewUrl"
        case artistIds = "artistIds"
        case releaseDate = "releaseDate"
        case trackId = "trackId"
        case trackName = "trackName"
        case genreIds = "genreIds"
        case currency = "currency"
        case kind = "kind"
        case artistId = "artistId"
        case artistName = "artistName"
        case genres = "genres"
        case price = "price"
        case resultDescription = "description"
        case userRatingCount = "userRatingCount"
        case averageUserRating = "averageUserRating"
    }
}
