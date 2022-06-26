//
//  MovieCardViewController.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 23/02/2022.
//

import UIKit
import UPCarouselFlowLayout
import RealmSwift

class MovieCardViewController: UIViewController  {
    
    @IBOutlet weak var collectionViewCard: UICollectionView!
    @IBOutlet weak var stackViewAddNewCard: UIStackView!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!
    
    let paymentMethodModel : PaymentMethodModel = PaymentMethodModelImpl.shared
    let myCheckOut = MyCheckOut.shared
    var cards = [CardObject]()
    var cardID = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewCard.isHidden = true
        lblTotalPrice.text = "$ \(myCheckOut._totalPrice)"
        tapGestureForNewCard()
        hideSpinner()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCards()
    }
    
    func updateUI() {
        collectionViewCard.isHidden = false
        let layout = UPCarouselFlowLayout()
        layout.itemSize.width = view.bounds.width * 0.8
        layout.itemSize.height = 200
        layout.scrollDirection = .horizontal
        layout.sideItemScale = 0.8
        layout.sideItemAlpha = 0.5
        layout.spacingMode = .overlap(visibleOffset: view.bounds.width * 0.05)
        collectionViewCard.collectionViewLayout = layout
        collectionViewCard.registerForCell(identifier: CreditCardCollectionViewCell.identifier)
        collectionViewCard.dataSource = self
        collectionViewCard.delegate = self
    }
    
    private func getCards() {
        paymentMethodModel.getCards { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.cards = data
                if self.cards.count > 0 {
                    self.cardID = self.cards.first!.id!
                    self.updateUI()
                }
                self.collectionViewCard.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
       
    fileprivate func tapGestureForNewCard(){
        let tapGestureForNewCard = UITapGestureRecognizer(target: self, action: #selector(onTapNewCard))
        stackViewAddNewCard.isUserInteractionEnabled = true
        stackViewAddNewCard.addGestureRecognizer(tapGestureForNewCard)
    }
    

    @objc func onTapNewCard(){
        navigateToMovieNewCardViewController()
    }
    
    private func registerTicket() {
        paymentMethodModel.registerTicket(checkout: myCheckOut.getCheckOut()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.hideSpinner()
                self.navigateToMovieTicketViewController(movieID: self.myCheckOut._movieID, tickedID: data.id!,cinemaID: self.myCheckOut._cinemaID)
                self.myCheckOut.reset()
            case .failure(let message):
                print(message)
            }
        }
    }

    @IBAction func btnConfirmClicked(_ sender: UIButton) {
        if cards.count > 0 {
            myCheckOut._cardID = cardID
            showSpinner()
            registerTicket()
        }
    }
    
    private func showSpinner() {
        spinnerIndicator.isHidden = false
        spinnerIndicator.startAnimating()
       // loadingView.isHidden = false
    }

    private func hideSpinner() {
        spinnerIndicator.isHidden = true
        spinnerIndicator.stopAnimating()
    }
    

}

extension MovieCardViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: CreditCardCollectionViewCell.identifier, indexPath: indexPath) as CreditCardCollectionViewCell
        cell.data = cards[indexPath.row]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        cardID = cards[indexPath.row].id!
//        print(cardID)
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = collectionViewCard.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = layout.itemSize.width
        let offset = scrollView.contentOffset.x

        cardID = cards[Int(floor((offset - pageSide / 2) / pageSide) + 1)].id!
        print(cardID)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(310), height: CGFloat(220))
    }
    
}
extension MovieCardViewController : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     //   scalingCarousel.didScroll()
    }
}
