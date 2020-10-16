//
//  URLImageView.swift
//  moviesApp
//
//  Created by Francisco Misael Landero Ychante on 14/10/20.
//

import SwiftUI

struct URLImageView: View {
    
    @ObservedObject var urlImageModel : UrlImageModel
    
    init(ulr : String?) {
        urlImageModel = UrlImageModel(imageName: ulr)
    }
     
    var body: some View {
            Image(uiImage: urlImageModel.image ?? URLImageView.defaultImage!)
                .resizable()
                .scaledToFit()
         
    }
    
    static var defaultImage = UIImage(named: "title")
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(ulr: "test")
    }
}
