//
//  Movie.swift
//  themoviedbapp
//
//  Created by Jhoan Gordillo Franco on 2/07/21.
//

import UIKit

// MARK: - PopularMoviesResponse
struct PopularMoviesResponse: Codable {
    let page: Int
    let movies: [Movie]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}



// MARK: - MovieDetail
struct MovieDetail: Codable {
    let id: Int
    let originalTitle: String
    let backdropPath: String
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case id
        case overview
    }
}

struct MovieDetailEntity {
    let movie: MovieDetail
    let img: UIImage?
}
