//
//  MoviePaymentViewController.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 22/02/2022.
//

import UIKit

class MoviePaymentViewController: UIViewController {
    
    
    @IBOutlet weak var constraintHeightSet: NSLayoutConstraint!
    
    @IBOutlet weak var constraintHeightPaymentMethod: NSLayoutConstraint!
    @IBOutlet weak var tfPromoCode: UITextField!
    @IBOutlet weak var tableViewSet: UITableView!
    @IBOutlet weak var tableViewPaymentMethod: UITableView!
    @IBOutlet weak var lblSnackPrice: UILabel!
    @IBOutlet weak var btnPay: UIButton!
    
    let paymentMethodModel : PaymentMethodModel = PaymentMethodModelImpl.shared
    let myCheckOut = MyCheckOut.shared
    var mySnacks = [Int : Int]()
    var snacksList : [SnackObject]?
    var paymentMethodList : [PaymentMethodObject]?
    var totalSnackPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tfPromoCode.setUnderLine()
        registerCells()
        setUpHeightForCollectionView()
        getSnacks()
        getPaymentMethod()
        updateUI()
    }
    
    fileprivate func registerCells(){
        tableViewSet.registerForCell(identifier: MovieComboTableViewCell.identifier)
        tableViewPaymentMethod.registerForCell(identifier: MoviePaymentTableViewCell.identifier)
    
    }

    fileprivate func setUpHeightForCollectionView() {
        constraintHeightSet.constant = 80 * 3
        constraintHeightPaymentMethod.constant = 55 * 3
        self.view.layoutIfNeeded()
    }

    fileprivate func updateUI() {
        lblSnackPrice.text = "\(totalSnackPrice)$"
        btnPay.setTitle("Pay $\(myCheckOut._totalPrice+totalSnackPrice)", for: .normal)
    }
    fileprivate func getSnacks() {
        paymentMethodModel.getSnacks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.snacksList = data
                self.tableViewSet.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    fileprivate func getPaymentMethod() {
        paymentMethodModel.getPaymentMethod { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.paymentMethodList = data
                self.tableViewPaymentMethod.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    @IBAction func btnPayClicked(_ sender: Any) {
        if mySnacks.count > 0 {
            var snackDict = [[String: Int?]]()
            mySnacks.forEach { key, value in
                let dict = ["id": key, "quantity": value ]
                snackDict.append(dict)
            }
            myCheckOut._snacks = snackDict
            myCheckOut._totalPrice = myCheckOut._totalPrice + totalSnackPrice
            navigateToMovieCardViewController()
        }
        
    }
    
}

extension MoviePaymentViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewSet {
            return snacksList?.count ?? 0
        } else {
            return paymentMethodList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewSet {
            let cell = tableView.dequeueCell(identifier: MovieComboTableViewCell.identifier, indexPath: indexPath) as MovieComboTableViewCell
            cell.data = snacksList![indexPath.row]
            cell.onTapItem = { (id, price, count) in
                self.totalSnackPrice += price
                if count > 0 {
                    self.mySnacks[id] = Int(count)
                }else {
                    self.mySnacks.removeValue(forKey: id)
                }
                self.updateUI()
            }
            return cell
        } else if tableView == tableViewPaymentMethod {
            let cell = tableView.dequeueCell(identifier: MoviePaymentTableViewCell.identifier, indexPath: indexPath) as MoviePaymentTableViewCell
            cell.data = paymentMethodList![indexPath.row]
            return cell
        }else {
            return UITableViewCell()
        }
       
    }
    
    
}
