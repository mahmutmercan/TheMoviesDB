//
//  CastsTVC.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 28.03.2021.
//

import UIKit
import Alamofire
import Kingfisher

class CastsTVC: UITableViewCell {

    static let identifier: String = "CastsTVC"
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    var selectedMovie: CastsModel?
//    var casts: [Cast] = []
    var selectedMovieId: Int = 0
    var selectCastHandler : ((_ selectedCast: Cast)->())?
    
    var casts: [Cast] = [] {
      didSet {
        self.collectionView.reloadData()
      }
    }


    
    override func awakeFromNib() {
        super.awakeFromNib()
        getMovieCasts(movieId: selectedMovieId)
        setupCollectionView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension CastsTVC {
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(GenreListCVC.nib(), forCellWithReuseIdentifier: GenreListCVC.identifier)
        collectionView.register(CastCVC.nib(), forCellWithReuseIdentifier: CastCVC.identifier)
                
        setupCollectionViewItemSize()
    }
    
    private func setupCollectionViewItemSize() {
        let screenSize = UIScreen.main.bounds.width
        let minimumLineSpacingValue: CGFloat = 8

        let itemW = (screenSize - 48) / 2
        let itemH = itemW * 1.4
        
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize = CGSize(width: Int(Float(itemW)), height: Int(itemH))
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = minimumLineSpacingValue
    }
}

extension CastsTVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = casts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCVC.identifier, for: indexPath) as! CastCVC
        cell.cellConfigure(posterImage: "sampleImage", movieName: "Artist Name Here")
        cell.titleLabel.text = item.name

        let imageUrl = Constant.MOVIE_DB_IMAGE_BASE_PATH.appending(item.profilePath ?? "")
        let placeHolder =  UIImage(named: "place")
        cell.castImageView.kf.setImage(
            with: URL(string: imageUrl),
            placeholder: placeHolder,
            options: [.transition(.fade(0.5))]
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectCastHandler!(self.casts[indexPath.row])

    }
    
}

// MARK: - Alamofire
extension CastsTVC {
    
  
    func getMovieCasts(movieId: Int) {
        
        let id: String = String(movieId)
        
        AF.request("https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(Constant.API_KEY)&language=en-US").validate().responseDecodable(of: CastsModel.self) { (response) in
            
          guard let movie = response.value else { return }
          self.selectedMovie = movie

          guard let casts = response.value?.cast else { return }
          self.casts = casts
          self.collectionView.reloadData()
        }
    }
}
