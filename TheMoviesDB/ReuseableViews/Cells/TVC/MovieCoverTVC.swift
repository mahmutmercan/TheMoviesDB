//
//  MovieCoverTVC.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 28.03.2021.
//

import UIKit
import Kingfisher

class MovieCoverTVC: UITableViewCell {
    static let identifier: String = "MovieCoverTVC"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var posterContainer: UIView!
    @IBOutlet weak var subTitle: UILabel!


    let placeholder = UIImage(named: "place")
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
     private func setupCell(){
        layer.backgroundColor = UIColor.black.cgColor
        layer.cornerRadius = 4
        coverImageView.contentMode = .scaleAspectFit
        
    }
    
    func configureCell(posterImage: String, movieName: String, rateLabel: String){
        
        let imageUrl = Constant.MOVIE_DB_IMAGE_BASE_PATH.appending(posterImage)
        
        self.coverImageView.kf.setImage(
            with: URL(string: imageUrl),
            placeholder: self.placeholder,
            options: [.transition(.fade(0.5))]
        )
        
        self.titleLabel.text = movieName
        self.subTitle.text = rateLabel
        
    }
    
}
