//
//  VideosTVC.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 28.03.2021.
//

import UIKit
class VideosTVC: UITableViewCell {

    
    static let identifier: String = "VideosTVC"
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    
    let placeholder = UIImage(named: "place")
    

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
    
}


extension VideosTVC {
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(VideoCVC.nib(), forCellWithReuseIdentifier: VideoCVC.identifier)
                
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


extension VideosTVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCVC.identifier, for: indexPath) as! VideoCVC

        cell.cellConfigure(previewImage: "sampleImage" )
        
        cell.cellTapAction = {
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 220, height: 150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
    
}
