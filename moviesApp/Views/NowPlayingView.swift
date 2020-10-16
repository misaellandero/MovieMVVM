//
//  NowPlayingView.swift
//  moviesApp
//
//  Created by Francisco Misael Landero Ychante on 07/10/20.
//

import SwiftUI

struct NowPlayingView: View {
    @EnvironmentObject private var stateController: StateController
    
    var body: some View {
        Content(movies: $stateController.movies)
            .onAppear{
                stateController.reloadMovies()
            }
    }
}

    struct Content: View {
        
        @EnvironmentObject private var stateController: StateController
        @Binding var movies: [Movie]
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        var body: some View {
            
            NavigationView{
                GeometryReader { geo in
                    ScrollView(.vertical) {
                               LazyVGrid(columns: columns, alignment: .center) {
                                   ForEach(movies, id: \.id) { movie in
                                    NavigationLink(destination:MovieDetailView(id: movie.id!)){
                                        MovieeCover(movie: movie)
                                            .frame(width: geo.size.width * 0.45)
                                            .cornerRadius(15)
                                            .onAppear{
                                                stateController.reloadMovies(item: movie)
                                            }
                                    }
                                    
                                   }
                               }
                               .padding()
                       }
           
                .navigationTitle("Peliculas")
                }
            }
            
        }
    }


    
    struct MovieeCover: View {
        @State var movie : Movie
        
        var body: some View {
            ZStack{
                
                URLImageView(ulr: movie.posterPath ?? "No image")
                   
                
                VStack{
                    Spacer()
                    Color.black.opacity(0.5)
                        .frame( height: 50)
                }
                
                VStack{
                    Spacer()
                    VStack{
                        HStack{
                            Text(movie.title ?? "Uknow")
                            .lineLimit(1)
                            Spacer()
                        }
                        HStack{
                            Text(movie.formatedDate)
                            Spacer()
                            Image(systemName: "star")
                                .foregroundColor(.yellow)
                            Text("\(String(format: "%.1f", movie.voteAverage ?? 0.0))")
                        }
                        .font(.caption)
                    }
                    .padding(10)
                    .foregroundColor(.white)
                    
                    
                }
            }
        }
    }
     
struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
