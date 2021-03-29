////
////  ViewController.swift
////  TheMoviesDB
////
////  Created by Mahmut MERCAN on 27.03.2021.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var collectionView: UICollectionView!
//    var layout = UICollectionViewFlowLayout()
//    @IBOutlet weak var searchbar: UISearchBar!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setInterface()
//    }
//
//
//    private func setInterface(){
//        setupCollectionView()
//        setTargets()
//    }
//}
//
//
//extension ViewController {
//    private func setTargets(){
//
//    }
//}
//
//extension ViewController {
//    private func setupCollectionView() {
//        collectionView.backgroundColor = .clear
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.setCollectionViewLayout(layout, animated: true)
//        collectionView.register(GenreListCVC.nib(), forCellWithReuseIdentifier: GenreListCVC.identifier)
//        collectionView.register(MovieCVC.nib(), forCellWithReuseIdentifier: MovieCVC.identifier)
//
//        setupCollectionViewItemSize()
//    }
//
//    private func setupCollectionViewItemSize() {
//        let screenSize = UIScreen.main.bounds.width
//        let minimumLineSpacingValue: CGFloat = 8
//
//        let itemW = (screenSize - 48) / 2
//        let itemH = itemW * 1.4
//
//
//        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
//        layout.itemSize = CGSize(width: Int(Float(itemW)), height: Int(itemH))
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.minimumLineSpacing = minimumLineSpacingValue
//    }
//
//}
//
//
//
//
//
//extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if (section == 0) {
//            return 2
//        } else if (section == 1) {
//            return 8
//        }
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//
//        if indexPath.section == 0 {
//            print("firstSection")
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCVC.identifier, for: indexPath as IndexPath) as! MovieCVC
//            cell.cellConfigure(posterImage: "SampleImage", movieName: "Movie Temp Name")
//
//            return cell
//
//        } else if indexPath.section == 1 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCVC.identifier, for: indexPath as IndexPath) as! MovieCVC
//
//            cell.cellConfigure(posterImage: "SampleImage", movieName: "UpcomingTemp Name")
//            cell.posterImageView.backgroundColor = .green
//
//            return cell
//        }
//
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCVC.identifier, for: indexPath as IndexPath) as! MovieCVC
//        cell.cellConfigure(posterImage: "SampleImage", movieName: "Movie Temp Name")
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("You selected cell #\(indexPath.item)!")
//
//    }
//
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//}
//
//
//
//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let cell: MovieCVC = Bundle.main.loadNibNamed(MovieCVC.identifier,
//                                                                      owner: self,
//                                                                      options: nil)?.first as? MovieCVC else {
//            return CGSize.zero
//        }
//        //cell.configureCell(name: names[indexPath.row])
//        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
//        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
//        return CGSize(width: size.width, height: 30)
//    }
//}
//
