//
//  DataResult.swift
//  Apple Music
//
//  Created by Abdallah on 8/22/21.
//

import Foundation
// MARK: - Result
struct DataResult: Codable {
    let wrapperType: String?
    let kind: String?
    let artistId: Int?
    let trackId: Int?
    let artistName: String?
    let trackName: String?
    let trackCensoredName: String?
    let artistViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: String?
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let contentAdvisoryRating: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType = "wrapperType"
        case kind = "kind"
        case artistId = "artistId"
        case trackId = "trackId"
        case artistName = "artistName"
        case trackName = "trackName"
        case trackCensoredName = "trackCensoredName"
        case artistViewUrl = "artistViewUrl"
        case trackViewUrl = "trackViewUrl"
        case previewUrl = "previewUrl"
        case artworkUrl30 = "artworkUrl30"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl100 = "artworkUrl100"
        case collectionPrice = "collectionPrice"
        case trackPrice = "trackPrice"
        case releaseDate = "releaseDate"
        case collectionExplicitness = "collectionExplicitness"
        case trackExplicitness = "trackExplicitness"
        case trackTimeMillis = "trackTimeMillis"
        case country = "country"
        case currency = "currency"
        case primaryGenreName = "primaryGenreName"
        case contentAdvisoryRating = "contentAdvisoryRating"
    }
}
