//
//  PersonDetailVC.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 30.03.2021.
//

import UIKit
import Alamofire
import Kingfisher

class PersonDetailVC: UIViewController {
    
    var selectedMovieId: Int = 0
    var selectedMovie: Movie?
    var selectedCast: Cast?
    var selectedCastId: Int = 0



    var selectedPersonId: Int = 0
    var selectedPerson: PersonModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedCastId)
        getPersonById(personId: selectedCastId)
        print(selectedPerson?.biography)
        
        
        let gestureSlideBack = UISwipeGestureRecognizer(target: self, action: #selector(self.backTapped))
                      gestureSlideBack.direction = .right
                      self.view.addGestureRecognizer(gestureSlideBack)

        // Do any additional setup after loading the view.
    }
    
    @objc func backTapped() {
            self.dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        }

    

}


// MARK: - Alamofire
extension PersonDetailVC {
 
    func getPersonById(personId: Int) {
        let id: String = String(personId)
        AF.request("https://api.themoviedb.org/3/\(Constant.person)/\(id)?api_key=\(Constant.API_KEY)&language=en-US").validate().responseDecodable(of: PersonModel.self) { (response) in
        
        guard let person = response.value else { return }
            print(person.birthday)
            print(person.biography)
        self.selectedPerson = person
        self.tableView.reloadData()
      }
    }
}
