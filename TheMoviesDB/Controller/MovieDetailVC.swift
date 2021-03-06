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
    
    var selectedMovie: Movie?
    var selectedMovieId: Int = 0
    
    var selectedPerson: PersonModel?
    var selectedPersonId: Int = 0
    
    var selectedCast: Cast?
    var selectedCastId: Int = 0
    
    
    
  @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      getMovieById(movieId: selectedMovie!.id)
        fetchPopularMovies()
        setUpTableView()
        let gestureSlideBack = UISwipeGestureRecognizer(target: self, action: #selector(self.backTapped))
                      gestureSlideBack.direction = .right
                      self.view.addGestureRecognizer(gestureSlideBack)
        
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

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Row 1 = CoverPhoto / title / Rating
        //Row 2 = summary
        //Row 3 = Cast
        //Row 4 = Video //        
        return 4
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let item = self.selectedMovie
        
        let selectedMovie = self.selectedMovie
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieCoverTVC.identifier, for: indexPath) as! MovieCoverTVC
            cell.selectionStyle = .none
            
            let imageUrl = Constant.MOVIE_DB_IMAGE_BASE_PATH.appending(item?.backdropPath ?? "")
            
            let placeHolder =  UIImage(named: "place")
            cell.coverImageView.kf.setImage(
                with: URL(string: imageUrl),
                placeholder: placeHolder,
                options: [.transition(.fade(0.5))]
            )
            
            cell.titleLabel.text = item?.originalTitle
            cell.subTitle.text = "Rate: " + String(item?.voteAverage ?? 0) + " / " + String(item?.voteCount ?? 0)

            tableView.beginUpdates()
            tableView.endUpdates()
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTVC.identifier, for: indexPath) as! SummaryTVC
            cell.selectionStyle = .none
            cell.summaryLabel.text = item?.overview
            
            
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CastsTVC.identifier, for: indexPath) as! CastsTVC
            cell.selectionStyle = .none
            cell.headerTitle.text = "Starring"
            cell.getMovieCasts(movieId: self.selectedMovieId)
            
            cell.selectCastHandler = { [weak self] selectedCast in
              guard let self = self else { return }
              
              self.selectedCast = selectedCast
                print(selectedCast.originalName)
                print(selectedCast.creditID)
                print(selectedCast.castID)
                print(selectedCast.id)
                self.selectedCastId = selectedCast.id
                print(self.selectedCastId)
                
              self.performSegue(withIdentifier: "PersonDetailVC", sender: nil)

            }
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let vc = segue.destination as? PersonDetailVC{
        vc.selectedCast = self.selectedCast
        vc.selectedCastId = self.selectedCastId
        
      }
    }

    
}

// MARK: - Alamofire
extension MovieDetailVC {
  
  func fetchPopularMovies() {
    AF.request("https://api.themoviedb.org/3/movie/\(Constant.popular)?api_key=\(Constant.API_KEY)&language=en-US&page=1").validate().responseDecodable(of: Movies.self) { (response) in
      
      guard let movies = response.value?.results else { return }
      self.films = movies
      self.items = self.films
      self.tableView.reloadData()
    }
  }
    
    func getMovieById(movieId: Int) {
        let id: String = String(movieId)
      AF.request("https://api.themoviedb.org/3/movie/\(id)?api_key=\(Constant.API_KEY)&language=en-US").validate().responseDecodable(of: Movie.self) { (response) in
        
        guard let movie = response.value else { return }
        self.selectedMovie = movie
        self.tableView.reloadData()
      }
    }
    
    func getPersonById(personId: Int) {
        let id: String = String(personId)
        AF.request("https://api.themoviedb.org/3/\(Constant.person)/\(id)?api_key=\(Constant.API_KEY)&language=en-US").validate().responseDecodable(of: PersonModel.self) { (response) in
        
            guard let person = response.value else { return }
        self.selectedPerson = person
        self.tableView.reloadData()
      }
    }
}
