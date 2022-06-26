//
//  MovieSeatViewController.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 15/02/2022.
//

import UIKit
import RxSwift

class MovieSeatViewController: UIViewController {

    @IBOutlet weak var collectionViewMovieSeat: UICollectionView!
    @IBOutlet weak var movieSeatHeight: NSLayoutConstraint!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblCinemaName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblTicket: UILabel!
    @IBOutlet weak var lblSeats: UILabel!
    @IBOutlet weak var btnBuyTickets: UIButton!
    @IBOutlet weak var stackBooking: UIStackView!
    
    var viewModel: MovieSeatViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = MovieSeatViewModel(cinemaModel: CinemaModelImpl.shared, myCheckOut: MyCheckOut.shared)
        bindViewState()
        registerCells()
        setUpDataSourceAndDelegate()
        viewModel.getSeatPlan()
        bindData()
        updateStackView()
    }
    
    private func bindViewState() {
        viewModel.viewState
            .subscribe(onNext: { [weak self] state in
                guard let self = self else { return }
                if let state = state {
                    switch state {
                    case .success:
                        self.setUpHeightForCollectionView()
                        self.collectionViewMovieSeat.reloadData()
                    case .failure(let message):
                        print(message)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindData() {
        lblMovieName.text = viewModel.movieName
        lblCinemaName.text = viewModel.cinemaName
        lblDateTime.text = viewModel.getDateAndTime()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = UIColor(named: "color_primary")
    }
    
    fileprivate func registerCells() {
        collectionViewMovieSeat.register(UINib(nibName: String(describing: MovieSeatCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MovieSeatCollectionViewCell.self))
    }
    
    fileprivate func setUpDataSourceAndDelegate() {
        collectionViewMovieSeat.allowsMultipleSelection = true
        collectionViewMovieSeat.dataSource = self
        collectionViewMovieSeat.delegate = self
    }
    
    fileprivate func setUpHeightForCollectionView() {
        movieSeatHeight.constant = CGFloat((30) * (Prefs.shared.getSeatColumn()))
        self.view.layoutIfNeeded()
    }
    
    fileprivate func didSelectMovieSeat(seat: SeatObject) {
        viewModel.addSelectedMovieSeat(newSeat: seat)
        updateUI()
    }
    
    fileprivate func didDeselectMovieSeat(seat: SeatObject) {
        viewModel.removeSelectedMovieSeat(seat: seat)
        updateUI()
    }
    
    private func updateUI() {
        viewModel.updateElements()
        lblTicket.text = "\(viewModel.getSelectedMovieSeatsCount())"
        lblSeats.text = viewModel.seatNumbber
        btnBuyTickets.setTitle("Buy Ticket for $\(viewModel.totalTicketPrice)", for: .normal)
        updateStackView()
    }
    
    private func updateStackView() {
        if viewModel.getSelectedMovieSeatsCount() > 0 {
            stackBooking.isHidden = false
        }else {
            stackBooking.isHidden = true
        }
    }

   

    @IBAction func btnBuyTicketClicked(_ sender: UIButton) {
        if viewModel.getSelectedMovieSeatsCount() > 0 {
            viewModel.setMyCheckOut()
            navigateToMoviePaymentViewController()
        }
       
    }
}

extension MovieSeatViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMovieSeatCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieSeatCollectionViewCell.self), for: indexPath) as? MovieSeatCollectionViewCell else { return UICollectionViewCell() }
        cell.movieSeat = viewModel.getMovieSeat(indexPath.row)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.getMovieType(indexPath.row) == SEAT_TYPE_AVAILABLE {
            didSelectMovieSeat(seat: viewModel.getMovieSeat(indexPath.row) )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if viewModel.getMovieType(indexPath.row) == SEAT_TYPE_AVAILABLE {
            didDeselectMovieSeat(seat: viewModel.getMovieSeat(indexPath.row) )
        }
    }
    
}

extension MovieSeatViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let seatRow = CGFloat(Prefs.shared.getSeatRow())
        let width = collectionView.bounds.width / seatRow
        let height = CGFloat(30)
        return CGSize(width: width, height: height)
    }
}
