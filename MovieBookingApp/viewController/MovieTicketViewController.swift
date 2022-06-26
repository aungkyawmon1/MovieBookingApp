//
//  MovieTicketViewController.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 23/02/2022.
//

import UIKit
import SDWebImage

class MovieTicketViewController: UIViewController {

    @IBOutlet weak var viewForCard: UIView!
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblRuntime: UILabel!
    @IBOutlet weak var lblBookingNo: UILabel!
    @IBOutlet weak var lblShowTime: UILabel!
    @IBOutlet weak var lblTheater: UILabel!
    @IBOutlet weak var lblScreen: UILabel!
    @IBOutlet weak var lblRow: UILabel!
    @IBOutlet weak var lblSeats: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var ivBarCode: UIImageView!
    
    let movieModel : MovieModel = MovieModelImpl.shared
    let paymentMethodModel : PaymentMethodModel = PaymentMethodModelImpl.shared
    let cinemaModel : CinemaModel = CinemaModelImpl.shared
    
    var movieID = 0
    var ticketID = 0
    var cinemaID = 0
    var isFromTicketHistory = false
    
    var ticket : TicketObject?
    var movie : MovieObject?
    var cinema : CinemaObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewForCard.dropShadow()
        ivMovie.layer.cornerRadius = 15
        ivMovie.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(onTapBack))
        getTicket()
        getCinema()
        getMovieDetail()
        print(isFromTicketHistory)
    }
    
    fileprivate func bindTicket(){
        lblBookingNo.text = ticket?.bookingNo
        lblPrice.text = ticket?.total
        lblRow.text = ticket?.row
        lblSeats.text = ticket?.seat
        lblScreen.text = "\(String(describing: ticket!.totalSeat! ))"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let date = dateFormatter.date(from:  ticket?.bookingDate ?? "")

        dateFormatter.dateFormat = "EEE MMM d yyyy"
        let date1 = dateFormatter.string(from: date!)
        lblShowTime.text = "\(date1) \(String(describing: ticket!.timeslot!.startTime!))"
        var qrpath = "\(Constant.profileURL)/\(ticket?.qrCode ?? "")"
        qrpath = qrpath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        ivBarCode.sd_setImage(with: URL(string: qrpath)?.absoluteURL)
    }
    
    fileprivate func bindMovie() {
        lblMovieName.text = movie?.originalTitle
        lblRuntime.text = movie?.getRuntimeFormat()
        let posterPath = "\(Constant.baseImageUrl)\(movie?.posterPath ?? "")"
        ivMovie.sd_setImage(with: URL(string: posterPath))
    }
    
    fileprivate func bindCinema() {
        lblTheater.text = cinema?.name
    }
    
    fileprivate func getTicket(){
        paymentMethodModel.getTicket(id: ticketID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.ticket = data
                self.bindTicket()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    fileprivate func getCinema() {
        cinemaModel.getCinemaById(id: cinemaID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.cinema = data
                self.bindCinema()
            case .failure(let message):
                print(message)
            }
        }
    }

    fileprivate func getMovieDetail() {
        movieModel.getDetail(id: movieID ){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.movie = data
                self.bindMovie()
            case .failure(let message):
                print(message)
            }
        }
    }

    @objc func onTapBack(){
        
        if isFromTicketHistory {
            self.navigationController?.popViewController(animated: true)
        }else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    

}
