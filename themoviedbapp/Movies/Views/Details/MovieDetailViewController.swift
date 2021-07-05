//
//  MovieDetailViewController.swift
//  themoviedbapp
//
//  Created by Jhoan Gordillo Franco on 3/07/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var headerMovieImage: UIImageView!
    @IBOutlet weak var textMovieDescription: UITextView!
    @IBOutlet weak var labelMovieDescriptionTitle: UILabel!
    @IBOutlet weak var loadinIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonView: UIView!
    
    var movieId: String! {
        didSet{
            fetchPopularMovies()
        }
    }
    var movie: MovieDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleViewData(hide: true)
    }
    
    func toggleViewData(hide: Bool) {
        headerMovieImage.isHidden = hide
        textMovieDescription.isHidden = hide
        labelMovieDescriptionTitle.isHidden = hide
        buttonView.isHidden = hide
        
        if hide {
            loadinIndicator.startAnimating()
        }else {
            loadinIndicator.stopAnimating()
        }
    }
    
    func setupMovieDetailView(movie: MovieDetail) {
        textMovieDescription.text = movie.overview
        labelMovieDescriptionTitle.text = movie.originalTitle
        fetchImageData(url: movie.backdropPath)
    }
    
    func fetchImageData(url: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/"+url)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)  else {
                return
            }
            
            print(httpResponse.statusCode)
            
            
            if  let data = data {
                DispatchQueue.main.sync {
                    self.headerMovieImage.image = UIImage(data: data)
                }
                
            }
            
        }.resume()
    }
    
    func fetchPopularMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId ?? "")?api_key=722ee383461b05037f58d4c09e1bd11a&language=en-US")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                print(httpResponse.statusCode)
            }
            
            
            if let data = data,
               let response = try? JSONDecoder().decode(MovieDetail.self, from: data) {
                
                self.movie = response
                
                DispatchQueue.main.sync {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.toggleViewData(hide: false)
                        self.setupMovieDetailView(movie: response)
                    }
                }
            }
            
            
        }.resume()
    }
    
    
}
