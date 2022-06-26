//
//  MovieDetailViewController.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 22/02/2022.
//

import UIKit
import SDWebImage
import Cosmos
import RealmSwift

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var viewForCornerRadius: UIView!
    @IBOutlet weak var lblOriginalTitle: UILabel!
    @IBOutlet weak var collectionViewGenre: UICollectionView!
    @IBOutlet weak var collectionViewCast: UICollectionView!
    @IBOutlet weak var ivPosterPath: UIImageView!
    @IBOutlet weak var lblRuntime: UILabel!
    @IBOutlet weak var svRating: CosmosView!
    @IBOutlet weak var lblIMDB: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    let movieRepository : MovieModel = MovieModelImpl.shared
    var movieID = -1
    var movieObject : MovieObject?
    var cast : List<Cast>?
    var genres : List<String>?
    let myCheckOut = MyCheckOut.shared
    
    let genreList = ["Action", "Adventure", "Mystery" ]
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        viewForCornerRadius.layer.cornerRadius = 15
        viewForCornerRadius.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        registerCells()
        setUpDelegateAndDataSource()
        getMovieDetail(id: movieID)
    }
    
    fileprivate func registerCells() {
        collectionViewGenre.registerForCell(identifier: GenreCollectionViewCell.identifier)
        
        collectionViewCast.registerForCell(identifier: CastCollectionViewCell.identifier)
    }
    
    fileprivate func setUpDelegateAndDataSource() {
        collectionViewGenre.dataSource = self
        collectionViewGenre.delegate = self
    }
    
    //MARK: - API CAll
    fileprivate func getMovieDetail(id : Int) {
        movieRepository.getDetail(id: id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.movieObject = data
                self.bindData()
            case .failure(let message):
                print(message)
            }
            
        }
    }
    
    fileprivate func bindData() {
        lblOriginalTitle.text = movieObject?.originalTitle
        lblIMDB.text = "IMDB \(movieObject?.rating ?? 0)"
        lblOverview.text = movieObject?.overview
        svRating.rating = Double(movieObject?.rating ?? 0) / 2
        lblRuntime.text = movieObject?.getRuntimeFormat()
        let backdropPath = "\(Constant.baseImageUrl)\( movieObject?.posterPath ?? "" )"
        ivPosterPath.sd_setImage(with: URL(string: backdropPath))
        cast = movieObject?.casts
        genres = movieObject?.genres
        collectionViewCast.reloadData()
        collectionViewGenre.reloadData()
    }
    
    @IBAction func btnGetYourTicketClicked(_ sender: UIButton) {
        myCheckOut._movieID = movieID
        myCheckOut._movieName = movieObject?.originalTitle ?? ""
        navigateToMovieTimeViewController(movieID: movieID)
    }
}

extension MovieDetailViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewGenre {
            return genres?.count ?? 0
        }else {
            return cast?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewGenre {
            let cell = collectionView.dequeueCell(identifier: GenreCollectionViewCell.identifier, indexPath: indexPath) as GenreCollectionViewCell
            cell.bindData(title: genres?[indexPath.row] ?? "")
            return cell
        }else{
            guard let cell = collectionView.dequeueCell(identifier: CastCollectionViewCell.identifier, indexPath: indexPath) as? CastCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.data = cast?[indexPath.row]
            return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewGenre {
            return CGSize(width: widthOfString(text: genres?[indexPath.row] ?? "", font: UIFont(name: "Helvetica Neue Thin", size: 14) ?? UIFont.systemFont(ofSize: 14)) + 40, height: 40)
        }else {
            return CGSize(width: CGFloat(70), height: CGFloat(70))
        }
    }
    
    func widthOfString(text : String, font : UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font : font]
        let textSize = text.size(withAttributes: fontAttributes)
        return textSize.width
    }
    
}
