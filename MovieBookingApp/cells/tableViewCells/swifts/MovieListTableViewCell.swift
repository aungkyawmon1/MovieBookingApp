//
//  MovieListTableViewCell.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 21/02/2022.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    weak var delegate : MovieItemDelegate? = nil
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    var data : [MovieObject]? {
        didSet{
            if let _ = data {
                collectionViewMovies.reloadData()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewMovies.dataSource = self
        collectionViewMovies.delegate = self
        collectionViewMovies.registerForCell(identifier: MovieListCollectionViewCell.identifier)
    }
    
    func bindData(title : String) {
        lblTitle.text = title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MovieListTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(identifier: MovieListCollectionViewCell.identifier, indexPath: indexPath) as? MovieListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = data?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width / 2.5 , height: CGFloat(250))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieID = data?[indexPath.row].id ?? 0
        delegate?.onTapMovie(id: movieID)
    }
    
    
}
