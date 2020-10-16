//
//  Movie.swift
//  moviesApp
//
//  Created by Francisco Misael Landero Ychante on 07/10/20.
//

import Foundation

struct Movie: Codable, Equatable {
    let posterPath: String?
    let id: Int?
    let title: String?
    let voteAverage: Double?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case title
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
    
    var formatedDate : String {
        
        let formatter = DateFormatter()
  
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date  = formatter.date(from: releaseDate!)
      
        formatter.dateStyle = .medium
        
        return formatter.string(from: date ?? Date())
    }
    
}
