//
//  MovieService.swift
//  moviesApp
//
//  Created by Francisco Misael Landero Ychante on 07/10/20.
//

import Foundation

public class MoviesService {
    
    private let apiKey = "?api_key=" + "634b49e294bd1ff87914e7b9d014daed"
    private let baseAPIURL = "https://api.themoviedb.org/3/movie/"
    private let language = "&language=" + "es-MX"
    
    var nextPageToLoad =  1
    
    var nowPlayingMovies = [Movie]()
    var movieDetail : MovieDetail?
    
    
    init() {
        loadNowPlaying()
    }
        
    func loadNowPlaying(){
  
        let urlString = "\(baseAPIURL)now_playing\(apiKey)\(language)&page=\(nextPageToLoad)"
        print(urlString)
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:parseMovies(data:response:error:))
        task.resume()
    }
    
    func parseMovies(data: Data?, response: URLResponse?, error: Error?){
            var NowPlayingMoviesResult = [Movie]()
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(NowPlaying.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async { [self] in
                        // update our UI
                      
                        NowPlayingMoviesResult = decodedResponse.results!
                        self.nextPageToLoad += 1
                        
                        for movie in NowPlayingMoviesResult {
                            nowPlayingMovies.append(movie)
                        }
                    }
                    // everything is good, so we can exit
                    return
                }
            }
            
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        
    }
    
    func loadDetailMovie(id : Int) {
        
        let urlString = String("\(baseAPIURL)\(id)\(apiKey)\(language)")
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler:parseDetailMovie(data:response:error:))
        task.resume()
         
    }
    
    func parseDetailMovie(data: Data?, response: URLResponse?, error: Error?){
            
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(moviesApp.MovieDetail.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        self.movieDetail  = decodedResponse
                    }
                    // everything is good, so we can exit
                    return
                }
            }
            
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        
    }
    
}

