//
//  MovieCVC.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 27.03.2021.
//

import UIKit
import Kingfisher

class MovieCVC: UICollectionViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterContainer: UIView!
    
    static let identifier: String = "MovieCVC"
    
    let placeholder = UIImage(named: "place")

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    
    private func setupCell(){
        layer.backgroundColor = UIColor.black.cgColor
        layer.cornerRadius = 4
        
        posterContainer.backgroundColor = UIColor.white
        posterContainer.layer.cornerRadius = 4
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        
        
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    func cellConfigure(posterImage: String, movieName: String){
        
        self.posterImageView.image = UIImage(named: posterImage)
        let imageUrl = Constant.MOVIE_DB_IMAGE_BASE_PATH.appending(posterImage)
        
        self.posterImageView.kf.setImage(
            with: URL(string: imageUrl),
            placeholder: self.placeholder,
            options: [.transition(.fade(0.5))]
        )
        
        self.titleLabel.text = movieName
    }
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
