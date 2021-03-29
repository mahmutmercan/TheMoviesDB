//
//  MovieDetailVC.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 28.03.2021.
//

import UIKit
import Alamofire
import Kingfisher

class MovieDetailVC: UIViewController {
    
    
    var films: [Movie] = []
    var items: [Movie] = []
    var selectedItem: Movie?
    var selectedMovieId: Int = 0
    var selectedMovie: Movie?
    

  @IBOutlet weak var tableView: UITableView!
  
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      getMovieById(movieId: selectedMovie!.id)
        fetchPopularMovies()
        setInterface()
        let gestureSlideBack = UISwipeGestureRecognizer(target: self, action: #selector(self.backTapped))
                      gestureSlideBack.direction = .right
                      self.view.addGestureRecognizer(gestureSlideBack)
        
    }
    
    private func setInterface(){
        setUpTableView()
        setTargets()
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 300;
        tableView.rowHeight = UITableView.automaticDimension
        
        //MARK: Register Nib Files
        tableView.register(MovieCoverTVC.nib(), forCellReuseIdentifier: MovieCoverTVC.identifier)
        tableView.register(SummaryTVC.nib(), forCellReuseIdentifier: SummaryTVC.identifier)
        tableView.register(CastsTVC.nib(), forCellReuseIdentifier: CastsTVC.identifier)
        tableView.register(VideosTVC.nib(), forCellReuseIdentifier: VideosTVC.identifier)
        
    }
    
    @objc func backTapped() {
            self.dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        }
    
}


extension MovieDetailVC {
    private func setTargets(){
        
    }
}


extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Row 1 = CoverPhoto / itle / Rating
        //Row 2 = summary
        //Row 3 = Cast
        //Row 4 = Video //        
        return 4
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let item = self.selectedMovie
        
        let selectedMovie = self.selectedMovie
        print(selectedMovie?.originalTitle)
        
        print(films.first?.originalTitle)
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieCoverTVC.identifier, for: indexPath) as! MovieCoverTVC
            cell.selectionStyle = .none
            
//            cell.configureCell(posterImage: item?.posterPath, movieName: item?.originalTitle, rateLabel: "23423423")
            print(item?.posterPath)
            let imageUrl = Constant.MOVIE_DB_IMAGE_BASE_PATH.appending(item?.posterPath ?? "")
            
            let placeHolder =  UIImage(named: "place")
            cell.posterImageView.kf.setImage(
                with: URL(string: imageUrl),
                placeholder: placeHolder,
                options: [.transition(.fade(0.5))]
            )
            
            cell.titleLabel.text = item?.originalTitle
            cell.rateLabel.text = "Rate: " + String(item?.voteAverage ?? 0) + " / " + String(item?.voteCount ?? 0)

            tableView.beginUpdates()
            tableView.endUpdates()
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTVC.identifier, for: indexPath) as! SummaryTVC
            cell.selectionStyle = .none
            cell.summaryLabel.text = item?.overview
            
//            cell.configure(summaryLabel: "Süpermen’in nihai fedakarlığının boşuna olmamasını sağlamaya kararlı olan Bruce Wayne, dünyayı felaket oranlarının yaklaşan bir tehdidinden korumak için bir meta insan ekibi oluşturma planlarıyla Diana Prince ile güçlerini birleştirir.")
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CastsTVC.identifier, for: indexPath) as! CastsTVC
            cell.selectionStyle = .none
            cell.headerTitle.text = "Starring"
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: VideosTVC.identifier, for: indexPath) as! VideosTVC
            cell.headerTitle.text = "Trailers"
            cell.selectionStyle = .none
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 350
        } else if indexPath.row == 2{
            return 240
        } else if indexPath.row == 3 {
            return 150
        }
        return UITableView.automaticDimension
    }
    
}






// MARK: - Alamofire
extension MovieDetailVC {
  
  func fetchPopularMovies() {
    AF.request("https://api.themoviedb.org/3/movie/\(Constant.popular)?api_key=\(Constant.API_KEY)&language=en-US&page=1").validate().responseDecodable(of: Movies.self) { (response) in
      
      print(response.value?.results.count)

      guard let movies = response.value?.results else { return }
      print(movies.first?.originalTitle)
      self.films = movies
        self.items = self.films
      self.tableView.reloadData()
    }
    
  }
    
    
    
    func getMovieById(movieId: Int) {
        let id: String = String(movieId)
      AF.request("https://api.themoviedb.org/3/movie/\(id)?api_key=\(Constant.API_KEY)&language=en-US").validate().responseDecodable(of: Movie.self) { (response) in
        
        print(response.value)

        guard let movie = response.value else { return }
        print(movie.originalTitle)
        self.selectedMovie = movie
        self.tableView.reloadData()
      }
      
    }
    


}
