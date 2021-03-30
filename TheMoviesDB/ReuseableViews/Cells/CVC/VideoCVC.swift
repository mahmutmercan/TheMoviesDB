//
//  CastCVC.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 28.03.2021.
//

import UIKit


class VideoCVC: UICollectionViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoPreviewImageView: UIImageView!
    @IBOutlet weak var videoPlayButtonImageView: UIImageView!
    @IBOutlet weak var videoContainer: UIView!
    
    static let identifier: String = "VideoCVC"
   

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
        
        videoContainer.backgroundColor = UIColor.white
        videoContainer.layer.cornerRadius = 4
        
        videoPreviewImageView.contentMode = .scaleAspectFill
        videoPreviewImageView.layer.cornerRadius = 4
        videoPreviewImageView.clipsToBounds = true
        
    }
    
    func cellConfigure(previewImage: String){
        self.videoPreviewImageView.image = UIImage(named: previewImage)
    }
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
