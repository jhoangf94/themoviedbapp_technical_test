//
//  ListMoviesPresenter.swift
//  themoviedbapp
//
//  Created by Jhoan Gordillo Franco on 3/07/21.
//

import Foundation

protocol ListMoviesViewDelegate: NSObjectProtocol {
    func displayListMovies(movies: [Movie])
    func loadingMovies()
    func displayError(message: String)
    func displayEmptyView()
}

class ListMoviesPresenter {
    private var viewDelegate: ListMoviesViewDelegate?
    private var moviesService: MoviesService
    
    init(moviesService: MoviesService) {
        self.moviesService = moviesService
    }
    
    func setViewDelegate(delegate: ListMoviesViewDelegate){
        viewDelegate = delegate
    }
    
    func loadMovies() {
        viewDelegate?.loadingMovies()
        moviesService.getPopularMovies({ [weak self] (movies, error) in
            
            if let _ = error {
                self?.viewDelegate?.displayError(message: "Oops, it's not you, it's us.")
            }
            
            if let movies = movies, movies.count > 0 {
                self?.viewDelegate?.displayListMovies(movies: movies)
            } else {
                self?.viewDelegate?.displayEmptyView()
            }
        })
    }
    
}
