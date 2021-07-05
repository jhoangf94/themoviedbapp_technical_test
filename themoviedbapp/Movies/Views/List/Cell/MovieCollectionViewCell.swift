//
//  MovieCollectionViewCell.swift
//  themoviedbapp
//
//  Created by Jhoan Gordillo Franco on 2/07/21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var labelMovieDate: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Specify which corners to round
        let corners = UIRectCorner(arrayLiteral: [
            UIRectCorner.topLeft,
            UIRectCorner.topRight,
        ])
        
        // Determine the size of the rounded corners
        let cornerRadii = CGSize(
            width: 10,
            height: 10
        )
        
        // A mask path is a path used to determine what
        // parts of a view are drawn. UIBezier path can
        // be used to create a path where only specific
        // corners are rounded
        let maskPath = UIBezierPath(
            roundedRect: image.bounds,
            byRoundingCorners: corners,
            cornerRadii: cornerRadii
        )
        
        // Apply the mask layer to the view
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        maskLayer.frame = image.bounds
        image.layer.mask = maskLayer
        
        backView.layer.cornerRadius = 10
        backView.layer.shadowRadius = 3
        backView.layer.shadowOpacity = 0.2
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = .init(width: 3, height: 4)
        backView.layer.masksToBounds = false
    }
    
    func setup(movie: Movie){
        labelMovieName.text = movie.title
        labelMovieDate.text = movie.releaseDate
        
        if let imgName = movie.backdropPath {
            fetchImageData(url: imgName)
        } else {
            self.image.image = UIImage(named: "movie")
        }
        
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
                    self.image.image = UIImage(data: data)
                }
                
            }
            
        }.resume()
    }
    
}
