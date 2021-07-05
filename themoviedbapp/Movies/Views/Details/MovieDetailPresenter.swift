//
//  MovieDetailPresenter.swift
//  themoviedbapp
//
//  Created by Jhoan Gordillo Franco on 4/07/21.
//

import UIKit

protocol MovieDetailViewDelegate {
    func displayMovie(movie: MovieDetailEntity)
    func loadingMovie()
    func loadingImg()
    func imgLoaded(img: UIImage)
    func displayError(message: String)
    func displayEmptyView()
}


class MovieDetailPresenter {
    private var view: MovieDetailViewDelegate?
    private var movieService: MoviesService
    
    
    init(service: MoviesService) {
        self.movieService = service
    }
    
    
    func setViewDelegate(view: MovieDetailViewDelegate) {
        self.view = view
    }
    
    func loadMovieDetail(movieId: Int) {
        view?.loadingMovie()
        
        movieService.getMovieDetail(movieId: movieId) { (movie, error) in
            if let _ = error {
                self.view?.displayError(message: "Error")
            }
            
            if let movieDetail = movie {
                let movieViewData = MovieDetailEntity(movie: movieDetail, img: nil)
                self.view?.displayMovie(movie: movieViewData)
                
                self.loadImg(imgId: movieDetail.backdropPath)
            }
        }
    }
    
    
    func loadImg(imgId: String) {
        self.view?.loadingImg()
        
        self.movieService.fetchImageData(imgId: imgId) { (img, err) in
            if let _ = err {
                self.view?.imgLoaded(img: UIImage(named: "movie")!)
            }
            
            if let img = img {
                self.view?.imgLoaded(img: UIImage(data: img)!)
            }
            
        }
    }
    
}
