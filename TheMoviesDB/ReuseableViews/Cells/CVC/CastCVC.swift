//
//  CastCVC.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 28.03.2021.
//

import UIKit


class CastCVC: UICollectionViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castContainer: UIView!
    
    static let identifier: String = "CastCVC"
    
   

    var cellTapAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    @IBAction func onAddToCartPressed(_ sender: Any) {
        cellTapAction?()
    }
    
    private func setupCell(){
        layer.backgroundColor = UIColor.black.cgColor
        layer.cornerRadius = 4
        
        castContainer.backgroundColor = UIColor.white
        castContainer.layer.cornerRadius = 4
        
        castImageView.contentMode = .scaleAspectFill
        castImageView.clipsToBounds = true
        
        
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    func cellConfigure(posterImage: String, movieName: String){
        self.castImageView.image = UIImage(named: posterImage)
        self.titleLabel.text = movieName
    }
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
