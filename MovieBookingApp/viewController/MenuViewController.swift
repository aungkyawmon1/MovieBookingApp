//
//  MenuViewController.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 21/02/2022.
//

import UIKit
import SDWebImage

class MenuViewController: UIViewController {

    @IBOutlet weak var ivProfileImage: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var stackViewLogOut: UIStackView!
    @IBOutlet weak var stackTicket: UIStackView!
    
    var profile : ProfileObject?
    let loginAndSigninModel : LoginAndSigninModel = LoginAndSigninModelImpl.shared
    let baseModel = BaseRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureForLogOut = UITapGestureRecognizer(target: self, action: #selector(tapOnLogOut))
        stackViewLogOut.isUserInteractionEnabled = true
        stackViewLogOut.addGestureRecognizer(tapGestureForLogOut)
        getProfile()
        
        let tapGestureForTickets = UITapGestureRecognizer(target: self, action: #selector(tapOnTickets))
        stackTicket.isUserInteractionEnabled = true
        stackTicket.addGestureRecognizer(tapGestureForTickets)
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func getProfile(){
        loginAndSigninModel.getProfile { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.bindData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    fileprivate func bindData() {
        lblProfileName.text = profile?.name
        lblEmail.text = profile?.email
        let profilePath = "\(Constant.profileURL)\(profile?.profileImage ?? "")"
        ivProfileImage.sd_setImage(with: URL(string: profilePath))
    }
    
    @objc func tapOnLogOut(){
       // dismiss(animated: true, completion: nil)
        
        loginAndSigninModel.logout { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                Prefs.shared.clearAllData()
                self.baseModel.clearAllData()
                self.navigateToLoginAndSignInViewController()
            case  .failure(let message):
                print(message)
            }
        }
    }
    
    @objc func tapOnTickets(){
        navigateToMovieTicketHistoryViewController()
    }

}
