//
//  MovieDetailModel.swift
//  moviesApp
//
//  Created by Francisco Misael Landero Ychante on 12/10/20.
//

import Foundation

class MovieDetailModel : ObservableObject {
    @Published var movie : MovieDetail?
     
    var urlString : String
    private let apiKey = "634b49e294bd1ff87914e7b9d014daed"
    
    init(id : Int) {
        self.urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=es-MX"
        loadDetailMovie()
    }
    
    func loadDetailMovie() {
        print(urlString)
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:parseDetailMovie(data:response:error:))
        task.resume()
    }
    
    func parseDetailMovie(data: Data?, response: URLResponse?, error: Error?){
       
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(MovieDetail.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async { [self] in
                        // update our UI
                      
                        movie = decodedResponse
                       
                    }
                    // everything is good, so we can exit
                    return
                }
            }
            
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        
    }
    
}


struct MovieDetail: Codable, Equatable {
    
    let id: Int?
    let posterPath: String?
    var title: String?
    let runtime: Int?
  
    let releaseDate: String?
    let voteAverage : Float
  
    let genres: [Genre]?
     
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case posterPath = "backdrop_path"
        case title
        case runtime
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genres
        case overview
        
    }
    
    var formatedDate : String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date  = formatter.date(from: releaseDate!)
      
        formatter.dateStyle = .medium
        
        return formatter.string(from: date ?? Date())
    }
    
    var genresString : [String] {
        var genresString = [String]()
        for genre in self.genres! {
            genresString.append(genre.name!)
        }
        
        return genresString
    }
    
}

// MARK: - Genre
struct Genre: Codable, Equatable {
    let id: Int?
    let name: String?
}

