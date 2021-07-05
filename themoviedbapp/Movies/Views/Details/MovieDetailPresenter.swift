//
//  MovieDetailPresenter.swift
//  themoviedbapp
//
//  Created by Jhoan Gordillo Franco on 4/07/21.
//

import Foundation

protocol MovieDetailViewDelegate {
    func displayMovie(movie: Movie)
    func loadingMovie()
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
    }
    
}
