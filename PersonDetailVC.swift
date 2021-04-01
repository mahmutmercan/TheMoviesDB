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
    @IBOutlet weak var personPhotoImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getPersonById(personId: selectedCastId)
        
        
        let gestureSlideBack = UISwipeGestureRecognizer(target: self, action: #selector(self.backTapped))
                      gestureSlideBack.direction = .right
                      self.view.addGestureRecognizer(gestureSlideBack)
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none

        
        
        //MARK: Register Nib Files
        
        tableView.register(SummaryTVC.nib(), forCellReuseIdentifier: SummaryTVC.identifier)
        tableView.register(MovieCoverTVC.nib(), forCellReuseIdentifier: MovieCoverTVC.identifier)
        
    }

    @objc func backTapped() {
            self.dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        }
}


extension PersonDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 2
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.selectedPerson

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieCoverTVC.identifier, for: indexPath) as! MovieCoverTVC
            
            let imageUrl = Constant.MOVIE_DB_IMAGE_BASE_PATH.appending(item?.profilePath
                                                                        ?? "")
            
            let placeHolder =  UIImage(named: "place")
            cell.coverImageView.kf.setImage(
                with: URL(string: imageUrl),
                placeholder: placeHolder,
                options: [.transition(.fade(0.5))]
            )
            
            cell.titleLabel.textAlignment = .center
            cell.subTitle.textAlignment = .center
            cell.titleLabel.text = item?.name ?? "Not Found"
            cell.subTitle.text = String(item?.birthday ?? "") + " - " + String(item?.placeOfBirth ?? "")
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTVC.identifier, for: indexPath) as! SummaryTVC
            cell.selectionStyle = .none
            cell.summaryLabel.text = item?.biography
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        } else if indexPath.row == 1 {
            return UITableView.automaticDimension
        }
        return 80
    }
    
    
}




// MARK: - Alamofire
extension PersonDetailVC {
 
    func getPersonById(personId: Int) {
        let id: String = String(personId)
        AF.request("https://api.themoviedb.org/3/\(Constant.person)/\(id)?api_key=\(Constant.API_KEY)&language=en-US").validate().responseDecodable(of: PersonModel.self) { (response) in
        
        guard let person = response.value else { return }
            print(person.name)
            print(person.id)
            print(person.birthday)
            print(person.biography)
        self.selectedPerson = person
        self.tableView.reloadData()
      }
    }
}
