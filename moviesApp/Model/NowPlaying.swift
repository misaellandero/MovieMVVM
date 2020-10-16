//
//  NowPlaying.swift
//  moviesApp
//
//  Created by Francisco Misael Landero Ychante on 07/10/20.
//

import Foundation

struct NowPlaying: Codable {
    let results: [Movie]?
    let page, totalResults: Int?
    let dates: Dates?
    let totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}
