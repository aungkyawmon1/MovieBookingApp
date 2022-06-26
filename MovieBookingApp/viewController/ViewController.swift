//
//  ViewController.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 14/02/2022.
//

import UIKit

class ViewController: UIViewController, MovieItemDelegate {

    @IBOutlet weak var tableViewHome: UITableView?
    let movieModel : MovieModel = MovieModelImpl.shared
    let loginAndSigninModel : LoginAndSigninModel = LoginAndSigninModelImpl.shared
    
    var comingSoonList : [MovieObject]?
    var nowShowingList : [MovieObject]?
    var profile : ProfileObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        registerCells()
        setUpDelegateAndDataSource()
        
        getProfile()
        getNowShowingList(status: "nowshowing")
        getComingSoon(status: "comingsoon")
     
        
    }
    
    fileprivate func getNowShowingList(status : String){
        movieModel.getMovieList(status: status) {  [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.nowShowingList = data
                self.tableViewHome?.reloadSections(IndexSet(integer: 1), with: .automatic)
            case .failure(let message):
                print("\(message)")
            }
            
        }
    }
    
    fileprivate func getComingSoon(status : String){
        movieModel.getMovieList(status: status) {  [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.comingSoonList = data
                self.tableViewHome?.reloadSections(IndexSet(integer: 2), with: .automatic)
            case .failure(let message):
                print("\(message)")
            }
            
        }
    }
    
    fileprivate func getProfile(){
        loginAndSigninModel.getProfile { (result) in
            
            switch result {
            case .success(let profile):
                self.profile = profile
                self.tableViewHome?.reloadSections(IndexSet(integer: 0), with: .automatic)
            case .failure(let message):
                print("\(message)")
            }
        }
    }
    
    fileprivate func registerCells() {
        tableViewHome?.registerForCell(identifier: HomeTitleTableViewCell.identifier)
        tableViewHome?.registerForCell(identifier: MovieListTableViewCell.identifier)
    }
    
    fileprivate func setUpDelegateAndDataSource(){
        tableViewHome?.dataSource = self
    }
    
    func onTapMovie(id : Int) {
        navigateToMovieDetailViewController(id: id)
    }


}

extension ViewController : UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueCell(identifier: HomeTitleTableViewCell.identifier, indexPath: indexPath) as? HomeTitleTableViewCell else { return UITableViewCell() }
            cell.data = profile
            return cell
        }else if indexPath.section == 1 {
            guard let cell = tableView.dequeueCell(identifier: MovieListTableViewCell.identifier, indexPath: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.bindData(title: "\(MovieSerieGroupType.nowShowing.rawValue)")
            cell.data = nowShowingList
            return cell
        }else if  indexPath.section == 2 {
            guard let cell = tableView.dequeueCell(identifier: MovieListTableViewCell.identifier, indexPath: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.bindData(title: "\(MovieSerieGroupType.comingSoon.rawValue)")
            cell.data = comingSoonList
            return cell
        }else {
            return UITableViewCell()
        }
       
    }
    
    
}
