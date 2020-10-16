//
//  MovieDetailView.swift
//  moviesApp
//
//  Created by Francisco Misael Landero Ychante on 12/10/20.
//

import SwiftUI

struct MovieDetailView: View {
    
    @EnvironmentObject private var stateController: StateController
    @State var id : Int
 
    var body: some View {
        DetailMovieContent(movie: $stateController.movie)
            .onAppear{
                stateController.loadMovieDetails(id: id)
            }
    }
}
    

struct DetailMovieContent: View {
    
    @Binding var movie : MovieDetail?
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                ScrollView(){
                    URLImageView(ulr:  movie?.posterPath)
                        .frame(width: geo.size.width)
                    VStack{
                        HStack{
                            Text(( movie?.title) ?? "Cargando")
                                    .font(.largeTitle)
                            Spacer()
                        }
                        .padding(.bottom, 20)
                
                        DetailRow(title: "Duración", content: String("\( movie?.runtime ?? 0) min"))
                        
                        DetailRow(title: "Fecha de estreno", content:  movie?.formatedDate ?? "0-0-0")
                        
                        DetailRow(title: "Calificación", content: (String(format: "%.1f",  movie?.voteAverage ?? 0.0)))
                        
                        DetailRow(title: "Géneros", content: String( movie?.genresString.joined(separator: ", ") ?? "Nada"))
                        
                        DetailRow(title: "Descripción", content: String("\( movie?.overview ?? "Nada")"))
                           
               
                    }
                    .padding(.leading,10)
                     
                }
                .navigationBarTitle( movie?.title ?? "Cargando", displayMode: .inline)
            }
        }
        
    }
}

struct DetailRow: View {
    @State var title : String
    @State var content : String
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(title)
                    .fontWeight(.bold)
                Text(content)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
    }
}
    


 

 
