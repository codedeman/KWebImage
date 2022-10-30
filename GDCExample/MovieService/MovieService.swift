//
//  MovieService.swift
//  GDCExample
//
//  Created by Kevin on 10/24/22.
//

import Foundation


class MovieService {
    typealias FilmDataCallBack = (FilmData) -> Void
    static let instance:MovieService = MovieService()
   
    func getListMovie(onSucess:FilmDataCallBack!) {
          let urlStr = "https://codedeman.github.io/ssd_api/fakeCinema.json"
        
        guard let url = URL(string: urlStr) else {return}
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, resonse, error  in
            guard let data = data else {return}
          guard   let obj = try? JSONDecoder().decode(FilmData.self, from:data) else {return}
            onSucess(obj)
        }.resume()
//          AF.request(url).validate().responseJSON { response  in
//              print("response +++++ ---  \(response.result)")
//              do {
//                  if let data = response.data  {
//                      let project = try JSONDecoder().decode(FilmData.self, from: data)
//                      onSucess(project)
//                  }
//              } catch {
//
//              }
//          }
      }
}


