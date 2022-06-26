//
//  WelcomeViewController.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 20/02/2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var btnGetStarted: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnGetStarted.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btnGetStarted.layer.borderWidth = 1
        btnGetStarted.layer.cornerRadius = 5
    }
    
    @IBAction func btnClickedGetStarted(_ sender: UIButton) {
        
        navigateToLoginAndSignInViewController()
    }
    

}
