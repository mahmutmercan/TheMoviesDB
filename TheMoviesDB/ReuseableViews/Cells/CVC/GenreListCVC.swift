//
//  GenreListCVC.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 27.03.2021.
//

import UIKit

struct GenreCM {
  var id: Int?
  var name: String?
}


class GenreListCVC: UICollectionViewCell {
    
    @IBOutlet weak private var container: UIView!
    
    @IBOutlet weak private var name: UILabel!
    static let identifier: String = "GenreListCVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Outlets
    
    
    // MARK: Setup
    
 
    
    override var isSelected: Bool{
        didSet{
            self.name.textColor = .yellow
        }
    }
    
    
    func populate(_ genre: GenreCM) {
        self.name.text = genre.name
    }
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
