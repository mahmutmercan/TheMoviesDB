//
//  Constant.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 28.03.2021.
//

import UIKit

class Constant {
    private init() {}
    
    static let MOVIE_DB_BASE_PATH = "https://api.themoviedb.org/3"
    static let MOVIE_DB_IMAGE_BASE_PATH = "https://image.tmdb.org/t/p/original"
    static let backdropImagePath = "https://image.tmdb.org/t/p/w500"
    static let API_KEY = "69e9b9c486b61d92564ad1217e018a2e"
    static let API_TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2OWU5YjljNDg2YjYxZDkyNTY0YWQxMjE3ZTAxOGEyZSIsInN1YiI6IjYwNWYyMTg0MjNiZTQ2MDA1MzlhMzg2NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sEIT5Kenkz23ZbJfC4bOL1_XKn3yX_uMz5s72TghcX0"
  static let popular = "popular"
  static let upcoming = "upcoming"
  
  static let headers = [
      "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
      "Content-Type": "application/x-www-form-urlencoded"
  ]
  
}
