//
//  MoviesTVC.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 27.03.2021.
//

import UIKit

protocol MoviesTVCDelegate {
  func selectMovie(selectedMovie: Movie)
}

class MoviesTVC: UITableViewCell {

    
    static let identifier: String = "MoviesTVC"
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    
  var films: [Movie] = [] {
    didSet {
      self.collectionView.reloadData()
    }
  }
    var upcomingFilms: [Movie] = []
    
    var imagePath: String = ""
    var movieName: String = ""
    var delegate: MoviesTVCDelegate!
    var selectMovieHandler : ((_ selectedMovie: Movie)->())?
    

    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    func configure(imagePath: String, movieName: String) {
        self.imagePath = imagePath
        self.movieName = movieName
    }
    
}


extension MoviesTVC {
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(GenreListCVC.nib(), forCellWithReuseIdentifier: GenreListCVC.identifier)
        collectionView.register(MovieCVC.nib(), forCellWithReuseIdentifier: MovieCVC.identifier)
                
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


extension MoviesTVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCVC.identifier, for: indexPath) as! MovieCVC
        cell.cellConfigure(posterImage: films[indexPath.row].posterPath, movieName: films[indexPath.row].originalTitle)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 185, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      self.selectMovieHandler!(self.films[indexPath.row])
    }
    
    
    
}


extension MoviesTVC {
    func openNextVC(storyboardName: String, vcName: String){
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vcName)
        vc.modalPresentationStyle = .fullScreen
        //self.present(vc, animated: true)
    }
}
