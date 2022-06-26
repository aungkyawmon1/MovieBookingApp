//
//  Route+Extension.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 21/02/2022.
//

import UIKit

enum StroyboardName : String {
    case Main = "Main"
    case Authentication = "Authentication"
    case LaunchScreen = "LaunchScreen"
}

extension UIStoryboard {
    static func mainStroyboard() -> UIStoryboard{
        UIStoryboard(name: StroyboardName.Main.rawValue, bundle: nil)
    }
    
    static func authenticationStoryboard() -> UIStoryboard {
        UIStoryboard(name: StroyboardName.Authentication.rawValue, bundle: nil)
    }
}

extension UIViewController{
    func navigateToMainViewController() {
        guard let vc = UIStoryboard.mainStroyboard().instantiateViewController(identifier:  UINavigationController.identifier) as? UINavigationController else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func navigateToLoginAndSignInViewController() {
        guard let vc = UIStoryboard.authenticationStoryboard().instantiateViewController(identifier:  LoginAndSignInViewController.identifier) as? LoginAndSignInViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func navigateToMovieDetailViewController(id: Int) {
        guard let vc = UIStoryboard.mainStroyboard().instantiateViewController(identifier:  MovieDetailViewController.identifier) as? MovieDetailViewController else { return }
        vc.movieID = id
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMoviePaymentViewController(){
        guard let vc = UIStoryboard.mainStroyboard().instantiateViewController(identifier:  MoviePaymentViewController.identifier) as? MoviePaymentViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieTicketViewController(movieID: Int, tickedID: Int, cinemaID: Int, isFromTicketHistory: Bool = false ){
        guard let vc = UIStoryboard.mainStroyboard().instantiateViewController(identifier:  MovieTicketViewController.identifier) as? MovieTicketViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.movieID = movieID
        vc.ticketID = tickedID
        vc.cinemaID = cinemaID
        vc.isFromTicketHistory = isFromTicketHistory
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieNewCardViewController(){
        guard let vc = UIStoryboard.mainStroyboard().instantiateViewController(identifier:  MovieNewCardViewController.identifier) as? MovieNewCardViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieCardViewController(){
        guard let vc = UIStoryboard.mainStroyboard().instantiateViewController(identifier:  MovieCardViewController.identifier) as? MovieCardViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieTimeViewController(movieID id: Int){
        guard let vc = UIStoryboard.mainStroyboard().instantiateViewController(identifier:  MovieTimeViewController.identifier) as? MovieTimeViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.movieID = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieSeatViewController(){
        guard let vc = UIStoryboard.mainStroyboard().instantiateViewController(identifier:  MovieSeatViewController.identifier) as? MovieSeatViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieTicketHistoryViewController() {
        guard let vc = UIStoryboard.mainStroyboard().instantiateViewController(identifier:  TicketsHistoryViewController.identifier) as? TicketsHistoryViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

