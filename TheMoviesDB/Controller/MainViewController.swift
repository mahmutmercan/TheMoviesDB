//
//  MovieItemDertailVC.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 27.03.2021.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    var films: [[Movie]] = [] // first array is Popular films, second array is upcoming films
    var selectedItem: Movie?
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
 
    var selectedMovie: Movie!
    var selectedMovieId: Int = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        fetchPopularMovies()
        tableView.reloadData()
    }
    
    private func setInterface(){
        setUpTableView()
        setTargets()
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MoviesTVC.nib(), forCellReuseIdentifier: MoviesTVC.identifier)
    }
    
}

extension MainViewController {
    private func setTargets(){
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTVC.identifier, for: indexPath) as! MoviesTVC
            cell.selectionStyle = .none
            cell.headerTitle.text = "Popular"
            cell.films = self.films[0]
          cell.selectMovieHandler = { [weak self] selectedMovie in
            guard let self = self else { return }
            
            self.selectedMovie = selectedMovie
            self.selectedMovieId = selectedMovie.id
            self.performSegue(withIdentifier: "MovieDetailVC", sender: nil)
            
          }
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTVC.identifier, for: indexPath) as! MoviesTVC
            cell.selectionStyle = .none
            cell.films = self.films[1]
            cell.headerTitle.text = "Upcoming"
            cell.selectMovieHandler = { [weak self] selectedMovie in
              guard let self = self else { return }
              
              self.selectedMovie = selectedMovie
              self.selectedMovieId = selectedMovie.id
              self.performSegue(withIdentifier: "MovieDetailVC", sender: nil)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 390
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let vc = segue.destination as? MovieDetailVC{
        vc.selectedMovie = self.selectedMovie
        vc.selectedMovieId = self.selectedMovieId
      }
    }
}

// MARK: - Alamofire
extension MainViewController {
  
  func fetchPopularMovies() {
    AF.request("https://api.themoviedb.org/3/movie/\(Constant.popular)?api_key=\(Constant.API_KEY)&language=en-US&page=1").validate().responseDecodable(of: Movies.self) { (response) in
      
      guard let movies = response.value?.results else { return }
      self.films.append(movies)
      self.tableView.reloadData()
      self.fetchUpcomingMovies()
    }
  }
    
    func fetchUpcomingMovies() {
        AF.request("https://api.themoviedb.org/3/movie/\(Constant.upcoming)?api_key=\(Constant.API_KEY)&language=en-US&page=1").validate().responseDecodable(of: Movies.self) { (response) in
        
        guard let movies = response.value?.results else { return }
        self.films.append(movies)
        self.tableView.reloadData()
      }
    }
}

