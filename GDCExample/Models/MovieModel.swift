//
//  MovieModel.swift
//  GDCExample
//
//  Created by Kevin on 10/24/22.
//

import Foundation

class FilmData:Codable {
    var listFilms:[FilmModel]?
    
}

class FilmDetailsModel:Codable{
    var id:String?
}

class FilmModel:Codable{
    var id:String?
    var filmUrl:String?
    var name:String?
    var price:String?
    var imageSize:Float?
    var age:String?
    var details: FilmDetailsModel?
    
    init(id:String,
         filmUrl:String,
         name:String,
         price:String,
         imageSize:Float,
         age:String,
         details:FilmDetailsModel? = nil
    ) {
        self.id = id
        self.filmUrl = filmUrl
        self.price = price
        self.age = age
        self.name = name
        self.details = details
    }
}
