//
//  TicketsHistoryViewController.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 11/05/2022.
//

import UIKit

class TicketsHistoryViewController: UIViewController {

    @IBOutlet weak var ticketsTableView: UITableView!
    
    var tickets = [TicketObject]()
    let paymentMethodModel : PaymentMethodModel = PaymentMethodModelImpl.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tickets"
        registerCells()
        getTicktes()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func registerCells() {
        ticketsTableView?.registerForCell(identifier: TicketTableViewCell.identifier)
    }
    
    fileprivate func getTicktes() {
        paymentMethodModel.getTickets { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.tickets = data
                self.ticketsTableView.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
}


extension TicketsHistoryViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(identifier: TicketTableViewCell.identifier, indexPath: indexPath) as? TicketTableViewCell else { return UITableViewCell() }
        cell.ticket = tickets[indexPath.row]
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = tickets[indexPath.row].movieID!
        let ticketId = tickets[indexPath.row].id!
        let cinemaId = tickets[indexPath.row].cinemaID!
        navigateToMovieTicketViewController(movieID: movieId, tickedID: ticketId, cinemaID: cinemaId, isFromTicketHistory: true)
    }
    
}
