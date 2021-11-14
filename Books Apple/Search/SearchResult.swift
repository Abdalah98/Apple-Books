//
//  SearchResult.swift
//  Apple Music
//
//  Created by Abdallah on 8/21/21.
//

import Foundation

// MARK: - SearchResult
struct SearchResult: Codable {
    let resultCount: Int?
    let results: [DataResult]?

    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case results = "results"
    }
}

