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
    
    func getMovieDetail(movieId: Int, _ callback: @escaping (MovieDetail?, Error?) -> Void) {
        let url = URL(string: "\(baseUrl)/movie/\(movieId)?api_key=\(apiKey)&language=en-US")!
        
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
               let movie = try? JSONDecoder().decode(MovieDetail.self, from: data) {

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    callback( nil, NSError(domain: "app", code: 100, userInfo: nil))
                    //callback(movie,nil)
                }
            }
        }.resume()
    }
    
    
    func fetchImageData(imgId: String, _ callback: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/"+imgId)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                callback(nil, error)
                print(error.localizedDescription)
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)  else {
                callback(nil, error)
                return
            }
            
            print(httpResponse.statusCode)
            
            
            if  let data = data {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    callback( nil, NSError(domain: "app", code: 100, userInfo: nil))
//                    callback(data,nil)
                }
                
            }
        }.resume()
    }
}
