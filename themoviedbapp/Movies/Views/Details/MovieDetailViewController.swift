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
    @IBOutlet weak var imgLoadigIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonView: UIView!
    
    private let presenter = MovieDetailPresenter(service: MoviesService())
    var movieId: Int!
    var movie: MovieDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(view: self)
        presenter.loadMovieDetail(movieId: movieId)
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
    
    func setupMovieDetailView(movie: MovieDetailEntity) {
        textMovieDescription.text = movie.movie.overview
        labelMovieDescriptionTitle.text = movie.movie.originalTitle
    }
}

extension MovieDetailViewController: MovieDetailViewDelegate {
    func loadingImg() {
        imgLoadigIndicator.isHidden = false
    }
    
    func imgLoaded(img: UIImage) {
        headerMovieImage.image = img
        imgLoadigIndicator.stopAnimating()
        headerMovieImage.isHidden = false
    }
    
    func displayMovie(movie: MovieDetailEntity) {
        imgLoadigIndicator.startAnimating()
        setupMovieDetailView(movie: movie)
        toggleViewData(hide: false)
    }
    
    func loadingMovie() {
        toggleViewData(hide: true)
    }
    
    func displayError(message: String) {
        loadinIndicator.stopAnimating()
        let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayEmptyView() {
        
    }
    
    
}
