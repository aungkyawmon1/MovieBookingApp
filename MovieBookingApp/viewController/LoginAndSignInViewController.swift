//
//  LoginAndSignInViewController.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 20/02/2022.
//

import UIKit

class LoginAndSignInViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblSignin: UILabel!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signinView: UIView!
    @IBOutlet weak var loginViewUnderline: UIView!
    @IBOutlet weak var signinViewUnderline: UIView!
    
    @IBOutlet weak var stackViewUsername: UIStackView!
    @IBOutlet weak var stackViewPhone: UIStackView!
    
    let loginAndSigninModel : LoginAndSigninModel = LoginAndSigninModelImpl.shared
    var isSignIn : Bool = false
    let googleAuth = GoogleAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfEmail.setUnderLine()
        tfPassword.setUnderLine()
        tfUsername.setUnderLine()
        tfPhone.setUnderLine()
        
        btnFacebook.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnFacebook.layer.borderWidth = 1
        btnFacebook.layer.cornerRadius = 5
        
        btnGoogle.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnGoogle.layer.borderWidth = 1
        btnGoogle.layer.cornerRadius = 5
        
        let tapGestureForLogin = UITapGestureRecognizer(target: self, action: #selector(tapOnLogin))
        loginView.isUserInteractionEnabled = true
        loginView.addGestureRecognizer(tapGestureForLogin)
        
        let tapGestureForSignin = UITapGestureRecognizer(target: self, action: #selector(tapOnSignIn))
        signinView.isUserInteractionEnabled = true
        signinView.addGestureRecognizer(tapGestureForSignin)
        // Do any additional setup after loading the view.
    }
    

    @objc func tapOnLogin() {
        
        signinViewUnderline.isHidden = true
        loginViewUnderline.isHidden = false
        lblLogin.textColor = UIColor(named: "color_primary")
        lblSignin.textColor = UIColor(named: "color_black")

        
        stackViewUsername.isHidden = true
        stackViewPhone.isHidden = true
        isSignIn = false
    }

    @objc func tapOnSignIn() {
        loginViewUnderline.isHidden = true
        signinViewUnderline.isHidden = false
        
        lblSignin.textColor = UIColor(named: "color_primary")
        lblLogin.textColor = UIColor(named: "color_black")
        
        stackViewUsername.isHidden = false
        stackViewPhone.isHidden = false
        isSignIn = true
    }
    
    @IBAction func btnGoogleLoginClicked(_ sender: UIButton) {
         
        googleAuth.start(view: self as? UIViewController, success: { [weak self](data) in
            guard let self = self else { return }
            if self.isSignIn {
                self.register(googleToken: data.id)
            }else {
              //  self.alertUI(title: "ll", message: "dd")
                self.signinWithGoogle(token: data.id)
            }
        }) { (err) in
           // handle error
        }
        
    }
    
    
    @IBAction func btnClickedConfirm(_ sender: UIButton) {
       // dismiss(animated: true, completion: nil)
        
        if isSignIn {
            do {
                try validateUserInputs()
                register()
            }catch InputError.inputInvalid(let message) {
                showToast(message: message)
                //self.alertUI(title: "Invalid input", message: message)
                print(message)
            }catch {
                print(error.localizedDescription)
            }
        }else {
            do {
                try validateUserInputs()
                loginAndSigninModel.getLogin(email: tfEmail.text!, password: tfPassword.text!){ [weak self](result) in
                  //  guard let self = self else { return }
                    switch result {
                    case .success( _):
                        self?.navigateToMainViewController()
                    case .failure(let message):
                        self?.showToast(message: message)
                    
                        //self?.alertUI(title: "Alert", message: message)
                        print(message)
                    }
                    
                }
            }catch InputError.inputInvalid(let message) {
                showToast(message: message)
                //self.alertUI(title: "Invalid input", message: message)
                print(message)
            } catch {
                
            }
        }
       
    }
    
    private func validateUserInputs() throws {
        if tfEmail.text == nil || !EmailValidation().isValidEmail(tfEmail.text!) {
            throw InputError.inputInvalid("Please enter a valid email address")
        }
        if tfPassword.text == nil || tfPassword.text!.isEmpty {
            throw InputError.inputInvalid("Please enter a password")
        }
        if (isSignIn) {
            if (tfUsername.text == nil || tfUsername.text!.isEmpty) {
                throw InputError.inputInvalid("Please enter a name")
            }
            if (tfPhone.text == nil || tfPhone.text!.isEmpty) {
            throw InputError.inputInvalid("Please enter a phone number")
            }
        }
    }
    
    fileprivate func signinWithGoogle(token: String) {
        loginAndSigninModel.getLoginWithGoogle(token: token) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success( _):
                self.navigateToMainViewController()
            case .failure(let message):
                self.showToast(message: message)
            }
        }
    }
    
    fileprivate func register(googleToken : String = "", facebookToken : String = "" ) {
        loginAndSigninModel.registerWithEmail(email: tfEmail.text!, password: tfPassword.text!, phone: tfPhone.text!, username: tfUsername.text!, googleToken: googleToken, facebookToken: facebookToken ) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success( _):
                self.navigateToMainViewController()
            case .failure(let message):
                self.showToast(message: message)
            }
            
        }
    }
    
//    private func alertUI(title: String,message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default)
//        alert.addAction(okAction)
//        self.present(alert, animated: true,completion: nil)
//
//    }
    
    fileprivate func showToast(message : String) {
//        CustomToast.show(message: message, bgColor: UIColor(named: "movie_seat_available_color")! , textColor: .red, labelFont: .systemFont(ofSize: 14), showIn: .top , controller: self)
        alertView.isHidden = false
        alertLabel.text = message
//        UIView.animate(withDuration: 5, delay: 0.0, options: .curveEaseIn, animations: {
//            self.alertView.alpha = 1.0
//        }) { (true) in
//            UIView.animate(withDuration: 5, delay: 1.5, options: .curveEaseOut, animations: {
//                self.alertView.alpha = 0.0
//            }) { (result) in
//                //self.alertView.isHidden = true
//                //toastView.removeFromSuperview()
//            }
//        }
     //   CustomToast.show(message: message, showIn: .top, controller: self)
        
    }
    
    enum InputError: Error {
        case inputInvalid(String)
    }
    
}
