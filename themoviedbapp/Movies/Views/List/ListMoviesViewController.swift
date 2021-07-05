//
//  ViewController.swift
//  themoviedbapp
//
//  Created by Jhoan Gordillo Franco on 2/07/21.
//

import UIKit

class ListMoviesViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var errorView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let listMoviesPresenter = ListMoviesPresenter(moviesService: MoviesService())
    var movies = [Movie]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidesWhenStopped = true
        listMoviesPresenter.setViewDelegate(delegate: self)
        listMoviesPresenter.loadMovies()
        registerMovieCollectionViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailViewController, let selectedMovie = sender as? Movie {
            vc.movieId = selectedMovie.id
        }
    }
    
    @IBAction func tryAgainButtonPressed(_ sender: UIButton) {
        listMoviesPresenter.loadMovies()
    }
    
    
    private func registerMovieCollectionViewCell(){
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        moviesCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }
}

extension ListMoviesViewController: ListMoviesViewDelegate {
    
    func displayListMovies(movies: [Movie]) {
        self.movies = movies
        moviesCollectionView.reloadData()
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        moviesCollectionView.isHidden = false
    }
    
    func loadingMovies() {
        errorView.isHidden = true
        moviesCollectionView.isHidden = true
        loadingIndicator.startAnimating()
    }
    
    func displayEmptyView() {
        loadingIndicator.stopAnimating()
    }
    
    func displayError(message: String) {
        loadingIndicator.stopAnimating()
        errorLabel.text = message
        errorView.isHidden = false
    }
}

extension ListMoviesViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        
        let movie = movies[indexPath.row]
        cell.setup(movie: movie)
        return cell
    }
}

extension ListMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 350)
    }
}

extension ListMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        performSegue(withIdentifier: "goToDetail", sender: selectedMovie)
    }
}

