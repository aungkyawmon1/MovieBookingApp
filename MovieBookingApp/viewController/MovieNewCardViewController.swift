//
//  MovieNewCardViewController.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 23/02/2022.
//

import UIKit

class MovieNewCardViewController: UIViewController {

    @IBOutlet weak var tfCardNumber: UITextField!
    @IBOutlet weak var tfCardHolder: UITextField!
    @IBOutlet weak var tfExpirationDate: UITextField!
    @IBOutlet weak var tfCVC: UITextField!
    
    let paymentMethodModel : PaymentMethodModel = PaymentMethodModelImpl.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tfCardNumber.setUnderLine()
        tfCardHolder.setUnderLine()
        tfExpirationDate.setUnderLine()
        tfCVC.setUnderLine()
        
    }
    
//    private func alertUI(title: String,message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default) { (result : UIAlertAction) -> Void in
//            if title == "Success" {
//              self.navigationController?.popViewController(animated: true)
//            }
//          }
//        alert.addAction(okAction)
//        self.present(alert, animated: true)
//
//    }
    
    fileprivate func showToast(message : String, textColor: UIColor = .red) {
        CustomToast.show(message: message, bgColor: UIColor(named: "movie_seat_available_color")! , textColor: .red, labelFont: .systemFont(ofSize: 14), showIn: .top , controller: self)
     //   CustomToast.show(message: message, showIn: .top, controller: self)
        
    }
    
    fileprivate func registerCard() {

        guard  let cardNumber = tfCardNumber.text, let cardHolder = tfCardHolder.text, let expirationDate = tfExpirationDate.text, let cvc = tfCVC.text else {

            return
        }
    
        do {
            try validateUserInputs()
            paymentMethodModel.registerCard(cardNumber: cardNumber, cardHolder: cardHolder, expirationDate: expirationDate, cvc: cvc) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_):
                    //self.alertUI(title: "Success", message: "You have successfully added a new card.")
                    self.showToast(message: "You have successfully added.", textColor: .green)
                    self.navigationController?.popViewController(animated: true)
                case .failure(let message):
                    self.showToast(message: message)
                   // self.alertUI(title: "Fail", message: message)

                }
            }
        }catch InputError.inputInvalid(let message) {
            showToast(message: message)
            //self.alertUI(title: "Invalid input", message: message)
            print(message)
        } catch {
            
        }
    }

    @IBAction func btnConfirmClicked(_ sender: UIButton) {
        registerCard()
    }
    
    private func validateUserInputs() throws {
        if tfCardNumber.text == nil || tfCardNumber.text!.count != 16 {
            throw InputError.inputInvalid("Credit card number must be 16 digits")
        }
        if tfCardHolder.text == nil || tfCardHolder.text!.isEmpty {
            throw InputError.inputInvalid("Please enter a card holder name")
        }
        if (tfExpirationDate.text == nil || tfExpirationDate.text!.isEmpty) {
            throw InputError.inputInvalid("Please enter an expiration date")
        }
        if (tfCVC.text == nil || tfCVC.text!.count != 3) {
        throw InputError.inputInvalid("CVC card number must be 3 digits")
        }
        
    }
    
    enum InputError: Error {
        case inputInvalid(String)
    }
    
}
