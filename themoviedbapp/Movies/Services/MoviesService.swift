//
//  MoviesService.swift
//  themoviedbapp
//
//  Created by Jhoan Gordillo Franco on 3/07/21.
//

import Foundation

class MoviesService {
    private let apiKey = "722ee383461b05037f58d4c09e1bd11a"
    private let baseUrl = "https://api.themoviedb.org/3"
    
    func getPopularMovies( _ callback:  @escaping ([Movie]?, _ error: Error? ) -> Void) {
        let url = URL(string: "\(baseUrl)/movie/popular?api_key=\(apiKey)&language=en-US&page=2")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
                       
            if let error = error {
                callback(nil, error)
                print(error.localizedDescription)
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else  {
                callback(nil, error)
                return
            }
            
            if let data = data,
               let response = try? JSONDecoder().decode(PopularMoviesResponse.self, from: data) {

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    //callback([], nil)
                    
                    callback(response.movies,nil)
                }
            }
        }.resume()
    }
}
